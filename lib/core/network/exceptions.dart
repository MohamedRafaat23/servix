 import 'package:equatable/equatable.dart';
import 'package:servix/main.dart' as ServixApp;
import '../utils/functions/translation.dart';
import '../../config/router/app_routes_names.dart';
import '../utils/functions/router_handler.dart';

import '../utils/constants/app_enums.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  FetchDataException([String? message])
    : super(message ?? "error_communication".trans);
}

class BadRequestException extends ServerException {
  BadRequestException([String? message]) : super(message ?? "bad_request".trans);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException([String? message])
    : super(message ?? "unauthorized".trans) {
    // appToast("unauthorized".trans );
  }
}

class NotFoundException extends ServerException {
  NotFoundException([String? message]) : super(message ?? "request_info".trans);
}

class ConflictException extends ServerException {
  ConflictException([String? message]) : super(message ?? "conflict".trans);
}

class InternalServerException extends ServerException {
  InternalServerException([String? message])
    : super(message ?? "server_failed".trans);
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException([String? message])
    : super(message ?? "no_internet".trans) {
    final context = ServixApp.navigatorKey.currentContext;

    if (context != null) {
      RouterHandler.navigate(
        context,
        AppRoutesNames.noInternet,
        routerType: RouterType.goName,
      );
    }
  }
}
