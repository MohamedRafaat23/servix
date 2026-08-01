// import 'dart:async';
// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:fawry_sdk/fawry_sdk.dart';
// import 'package:fawry_sdk/model/bill_item.dart';
// import 'package:fawry_sdk/model/fawry_launch_model.dart';
// import 'package:fawry_sdk/model/launch_customer_model.dart';
// import 'package:fawry_sdk/model/launch_merchant_model.dart';
// import 'package:fawry_sdk/model/payment_methods.dart';
// import 'package:fawry_sdk/model/response.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../constants/fawry_constants.dart';

// typedef FawryPaymentCallback = void Function(ResponseStatus response);
// typedef FawryErrorCallback = void Function(String error);

// class FawryHandler {
//   static StreamSubscription<dynamic>? _subscription;
//   static FawryPaymentCallback? _onSuccess;
//   static FawryErrorCallback? _onError;

//   static void initCallback() {
//     _subscription?.cancel();
//     _subscription = FawrySDK.instance.callbackResultStream().listen(
//       _handleCallbackEvent,
//       onError: (Object error) {
//         debugPrint('[FAWRY] callback stream error: $error');
//         _onError?.call(error.toString());
//       },
//     );
//   }

//   static void _handleCallbackEvent(dynamic event) {
//     if (event == null) return;

//     try {
//       final ResponseStatus response = event is String
//           ? ResponseStatus.fromJson(jsonDecode(event) as Map<String, dynamic>)
//           : ResponseStatus.fromJson(Map<String, dynamic>.from(event as Map));

//       debugPrint('[FAWRY] status=${response.status} message=${response.message}');

//       switch (response.status) {
//         case FawrySDK.RESPONSE_SUCCESS:
//         case FawrySDK.RESPONSE_PAYMENT_COMPLETED:
//           _onSuccess?.call(response);
//           break;
//         case FawrySDK.RESPONSE_ERROR:
//           _onError?.call(response.message ?? 'Payment Error');
//           break;
//       }
//     } catch (error) {
//       debugPrint('[FAWRY] callback parse error: $error event=$event');
//     }
//   }

//   static String generateFawrySignature({
//     required String merchantCode,
//     required String merchantRefNum,
//     required String customerProfileId,
//     required List<BillItem> items,
//     required String secureKey,
//     bool isPaymentSignature = true,
//   }) {
//     final validItems = items
//         .where(
//           (item) =>
//               item.itemId.isNotEmpty && item.quantity != 0 && item.price != 0,
//         )
//         .toList();

//     if (isPaymentSignature && validItems.isEmpty) {
//       throw Exception('No valid items found for signature generation');
//     }

//     if (validItems.isNotEmpty) {
//       validItems.sort((a, b) => a.itemId.compareTo(b.itemId));
//     }

//     String formatPrice(dynamic value) {
//       final parsed = double.tryParse(value?.toString() ?? '0') ?? 0;
//       return parsed.toStringAsFixed(2);
//     }

//     final itemsString = validItems.map((item) {
//       return '${item.itemId}${item.quantity}${formatPrice(item.price)}';
//     }).join();

//     final signatureString = merchantCode +
//         (isPaymentSignature ? merchantRefNum : '') +
//         customerProfileId +
//         (isPaymentSignature ? itemsString : '') +
//         secureKey;

//     if (kDebugMode) {
//       debugPrint(
//         '[FAWRY] ${isPaymentSignature ? 'payment' : 'tokenization'} signature: $signatureString',
//       );
//     }

//     return sha256.convert(utf8.encode(signatureString)).toString();
//   }

//   static Future<void> launchFawryPayment({
//     required BuildContext context,
//     required String merchantCode,
//     required String merchantRefNumber,
//     required String customerProfileId,
//     required String customerMobile,
//     required String customerEmail,
//     required String customerName,
//     required List<BillItem> items,
//     required String secureKey,
//     String? baseURL,
//     String lang = FawrySDK.LANGUAGE_ARABIC,
//     required FawryPaymentCallback onResult,
//     required FawryErrorCallback onError,
//   }) async {
//     try {
//       _onSuccess = onResult;
//       _onError = onError;
//       initCallback();

//       final paymentSignature = generateFawrySignature(
//         merchantCode: merchantCode,
//         merchantRefNum: merchantRefNumber,
//         customerProfileId: customerProfileId,
//         items: items,
//         secureKey: secureKey,
//         isPaymentSignature: true,
//       );

//       final tokenizationSignature = generateFawrySignature(
//         merchantCode: merchantCode,
//         merchantRefNum: merchantRefNumber,
//         customerProfileId: customerProfileId,
//         items: items,
//         secureKey: secureKey,
//         isPaymentSignature: false,
//       );

//       final model = FawryLaunchModel(
//         allow3DPayment: true,
//         skipLogin: true,
//         skipReceipt: false,
//         payWithCardToken: true,
//         paymentMethods: PaymentMethods.ALL,
//         launchMerchantModel: LaunchMerchantModel(
//           merchantCode: merchantCode,
//           merchantRefNum: merchantRefNumber,
//         ),
//         launchCustomerModel: LaunchCustomerModel(
//           customerProfileId: customerProfileId,
//           customerMobile: customerMobile,
//           customerEmail: customerEmail,
//           customerName: customerName,
//         ),
//         chargeItems: items,
//         paymentSignature: paymentSignature,
//         tokenizationSignature: tokenizationSignature,
//       );

//       var finalBaseURL = baseURL ?? FawryConstants.baseUrl;
//       if (!finalBaseURL.endsWith('/')) {
//         finalBaseURL = '$finalBaseURL/';
//       }

//       debugPrint('[FAWRY] starting payment baseURL=$finalBaseURL');

//       await FawrySDK.instance.startPayment(
//         launchModel: model,
//         baseURL: finalBaseURL,
//         lang: lang,
//       );
//     } catch (e) {
//       onError(e.toString());
//     }
//   }

//   static String normalizeEgyptianMobile(String? phone) {
//     if (phone == null || phone.trim().isEmpty) {
//       return '01000000000';
//     }

//     var digits = phone.replaceAll(RegExp(r'\D'), '');
//     if (digits.startsWith('20') && digits.length >= 12) {
//       digits = digits.substring(2);
//     }
//     if (digits.startsWith('0')) {
//       return digits;
//     }
//     if (digits.length == 10) {
//       return '0$digits';
//     }
//     return digits;
//   }
// }
