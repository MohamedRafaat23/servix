import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:servix/core/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api_model.dart';
import '../utils/constants/app_enums.dart';
import '../utils/functions/callback_token.dart';
import '../utils/functions/common_fun.dart';
import '../utils/functions/guest_helper.dart';
import '../utils/functions/log_out.dart';
import '../di/service_locator.dart';
import '../utils/functions/translation.dart';
import 'end_points.dart';
import 'exceptions.dart';
import 'status_code.dart';
import 'api_consumer.dart';
import 'network_info.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  // ✅ اتشالت الـ Object object اللي مالهاش لازمة
  DioConsumer(this.client) {
    client.interceptors.addAll([
      _connectivityInterceptor(),
      _languageInterceptor(),
      _authInterceptor(),
      if (kDebugMode) HttpFormatter(),
    ]);

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..connectTimeout = const Duration(milliseconds: 30000)
      ..receiveTimeout = const Duration(milliseconds: 30000)
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status != null && status < 500 && status != 401;
      };
  }

  @override
  Future<Either<String, ApiModel>> globalApiGet(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      final isError =
          response.statusCode == 400 ||
          response.statusCode == 403 ||
          response.statusCode == 404;

      return isError
          ? left(handleResponseAsJson(response)['message'])
          : right(
              ApiModel(
                response: handleResponseAsJson(response),
                statusCode: response.statusCode!,
              ),
            );
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> getPrivate(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(),
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> post(
    String path, {
    dynamic body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> put(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> patchFormData(
    String path, {
    FormData? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: {'Accept': 'application/json'}),
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ApiModel>> auth(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        options: Options(extra: {'requiresToken': false}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(
          ApiModel(
            response: handleResponseAsJson(response),
            statusCode: response.statusCode!,
          ),
        );
      } else {
        final json = handleResponseAsJson(response);
        String error = json['message'] ?? json['error'] ?? "unknown_error".trans;
        if (json['detail'] != null) {
          if (json['detail'] is List && json['detail'].isNotEmpty) {
            error = json['detail'][0].toString();
          } else {
            error = json['detail'].toString();
          }
        }
        if (json['errors'] != null && json['errors'] is Map) {
          final errors = json['errors'] as Map;
          if (errors.containsKey('non_field_errors') &&
              errors['non_field_errors'] is List &&
              errors['non_field_errors'].isNotEmpty) {
            error = errors['non_field_errors'][0].toString();
          } else {
            List<String> allErrors = [];
            errors.forEach((key, value) {
              if (value is List && value.isNotEmpty) {
                allErrors.add(value[0].toString());
              } else {
                allErrors.add(value.toString());
              }
            });
            if (allErrors.isNotEmpty) {
              error = allErrors.join("\n");
            }
          }
        }
        final fieldErrors = <String, String>{};
        for (final entry in json.entries) {
          if (entry.key == 'message' ||
              entry.key == 'error' ||
              entry.key == 'detail' ||
              entry.key == 'errors' ||
              entry.key == 'is_verified') {
            continue;
          }
          if (entry.value is List && (entry.value as List).isNotEmpty) {
            fieldErrors[entry.key] = (entry.value as List).first.toString();
          } else if (entry.value is String && entry.value.isNotEmpty) {
            fieldErrors[entry.key] = entry.value;
          }
        }
        if (fieldErrors.isNotEmpty &&
            (json['message'] == null && json['error'] == null)) {
          error = fieldErrors.values.first;
        }
        return left({
          "message": error,
          "is_verified": json['is_verified'] ?? true,
          if (fieldErrors.isNotEmpty) "fields": fieldErrors,
        });
      }
    } on DioException catch (e) {
      return left({"message": handleDioError(e).toString()});
    }on ServerException catch (e) {
    return left({"message": e.message});
  } catch (e) {
    return left({"message": "unexpected_error".trans});
  }
  }
@override
Map<String, dynamic> handleResponseAsJson(Response response) {
  if (response.data == null || response.data.toString().trim().isEmpty) {
    return {};
  }

  final raw = response.data.toString();

  try {
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return {'results': decoded};
    }
    return decoded as Map<String, dynamic>;
  } on FormatException catch (_) {
    throw ServerException(
      'Invalid response from server. Please check your connection and try again.',
    );
  }
}

  @override
  Either<String, ApiModel> handleResponseStatus(Response response) {
    final status = response.statusCode ?? 0;

    // ✅ إضافة  ?? 'error' في الآخر عشان الـ type يبقى String مش String?
    final Map<int, String> errorMessages = {
      StatusCode.forbidden:
          handleResponseAsJson(response)['message'] ??
          handleResponseAsJson(response)['error'] ??
          response.statusMessage ??
          'error',
      StatusCode.unauthorized:
          handleResponseAsJson(response)['message'] ??
          handleResponseAsJson(response)['error'] ??
          response.statusMessage ??
          'error',
      StatusCode.timeOut1: "Time Out",
      StatusCode.timeOut2: "Time Out",
      StatusCode.timeOut3: "Time Out",
      StatusCode.notFound:
          handleResponseAsJson(response)['message'] ??
          handleResponseAsJson(response)['error'] ??
          response.statusMessage ??
          'error',
      StatusCode.badRequest:
          handleResponseAsJson(response)['message'] ??
          handleResponseAsJson(response)['error'] ??
          response.statusMessage ??
          'error',
    };

    if (errorMessages.containsKey(status)) {
      final json = handleResponseAsJson(response);
      String errorMessage = errorMessages[status]!;

      if (json['errors'] != null && json['errors'] is Map) {
        final errors = json['errors'] as Map;
        if (errors.containsKey('non_field_errors') &&
            errors['non_field_errors'] is List &&
            errors['non_field_errors'].isNotEmpty) {
          errorMessage = errors['non_field_errors'][0].toString();
        } else if (errors.isNotEmpty) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            errorMessage = firstError[0].toString();
          } else {
            errorMessage = firstError.toString();
          }
        }
      }

      return left(errorMessage);
    }

    return right(
      ApiModel(response: handleResponseAsJson(response), statusCode: status),
    );
  }

  @override
  Exception handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return FetchDataException();

      case DioExceptionType.cancel:
        return FetchDataException();

      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return NoInternetConnectionException();

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NoInternetConnectionException();
        }
        return FetchDataException(error.message);

      case DioExceptionType.badResponse:
        final code = error.response?.statusCode ?? 0;
        switch (code) {
          case StatusCode.badRequest:
            return BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            return UnauthorizedException();
          case StatusCode.notFound:
            return NotFoundException();
          case StatusCode.conflict:
            return ConflictException();
          case StatusCode.internalServerError:
            return InternalServerException();
          default:
            return FetchDataException("Unexpected server error: $code");
        }
    }
  }

  InterceptorsWrapper _languageInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final languageCode = await _resolveLanguageCode();
        options.headers[Constants.acceptLanguage] = languageCode;
        options.headers['lang'] = languageCode;
        handler.next(options);
      },
    );
  }

  Future<String> _resolveLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString('locale');
    if (savedLocale != null && savedLocale.isNotEmpty) {
      return savedLocale.split('_').first.split('-').first;
    }

    final storedLang = await sl<HandleMulticallLocal>().getLocalData(
      keyType: LocalEnumKey.languageCode,
    );
    if (storedLang != null && storedLang.isNotEmpty) {
      return storedLang;
    }

    return Constants.arCode;
  }

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.extra['requiresToken'] != false) {
          final token = await sl<HandleMulticallLocal>().getLocalData(
            keyType: LocalEnumKey.accessToken,
          );
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }

        handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (e.response?.statusCode == 401) {
          final refreshToken = await sl<HandleMulticallLocal>().getLocalData(
            keyType: LocalEnumKey.refreshToken,
          );
          final canRefresh = !GuestHelper.isGuestMode() &&
              refreshToken != null &&
              refreshToken.isNotEmpty;

          if (canRefresh) {
            try {
              final response = await _handle401AndRetry(e.requestOptions);
              if (response != null) return handler.resolve(response);
            } catch (_) {
              await logOut();
              return handler.next(e);
            }
          }

          return handler.next(e);
        }

        if (e.type == DioExceptionType.connectionError ||
            e.error is SocketException ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          showToast("connection_error".trans, state: ToastStates.error);

          const int maxRetries = 3;
          const Duration retryDelay = Duration(seconds: 5);

          for (int attempt = 1; attempt <= maxRetries; attempt++) {
            await Future.delayed(retryDelay);

            if (await sl<NetworkInfo>().isConnected) {
              try {
                final retryResponse = await client.fetch(e.requestOptions);
                return handler.resolve(retryResponse);
              } catch (err) {
                if (attempt == maxRetries &&
                    (err is DioException && err.response?.statusCode == 401)) {
                  await logOut();
                }
              }
            }

            if (attempt == maxRetries) {
              return handler.reject(e);
            }
          }
        }

        return handler.reject(e);
      },
    );
  }

  InterceptorsWrapper _connectivityInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final results = await sl<Connectivity>().checkConnectivity();
        if (results.contains(ConnectivityResult.none)) {
          return handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.connectionError,
              message: 'No internet connection',
            ),
          );
        }
        handler.next(options);
      },
    );
  }

  Completer<void>? _refreshTokenCompleter;

  Future<Response?> _handle401AndRetry(RequestOptions requestOptions) async {
    if (_refreshTokenCompleter != null) {
      await _refreshTokenCompleter!.future;
    } else {
      _refreshTokenCompleter = Completer();
      try {
        await _refreshToken();
        _refreshTokenCompleter!.complete();
        _refreshTokenCompleter = null;
      } catch (e) {
        _refreshTokenCompleter!.completeError(e);
        _refreshTokenCompleter = null;
        rethrow;
      }
    }

    final newHeaders = Map<String, dynamic>.from(requestOptions.headers);
    final newAccessToken = await sl<HandleMulticallLocal>().getLocalData(
      keyType: LocalEnumKey.accessToken,
    );
    newHeaders['Authorization'] = 'Bearer $newAccessToken';
    newHeaders[Constants.acceptLanguage] = await _resolveLanguageCode();
    newHeaders['lang'] = newHeaders[Constants.acceptLanguage];
    newHeaders['isRetry'] = true;

    return client.fetch(requestOptions.copyWith(headers: newHeaders));
  }

  Future<void> _refreshToken() async {
    final refreshToken = await sl<HandleMulticallLocal>().getLocalData(
      keyType: LocalEnumKey.refreshToken,
    );
    if (refreshToken == null) throw Exception('Refresh token missing');
    final response = await client.post(
      EndPoints.refreshTokenApi,
      data: {"refresh": refreshToken},
      options: Options(extra: {'requiresToken': false}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.data.toString());
      final newAccess = data['access'];
      final newRefresh = data['refresh'];

      await sl<HandleMulticallLocal>().saveLocalData(
        keyType: LocalEnumKey.accessToken,
        data: newAccess,
      );
      await sl<HandleMulticallLocal>().saveLocalData(
        keyType: LocalEnumKey.refreshToken,
        data: newRefresh,
      );
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}