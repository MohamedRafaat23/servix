import 'package:servix/core/utils/constants/app_constants.dart';

import '../utils/functions/remote_config_helper.dart';

class EndPoints {
  static String get baseUrl => Constants.baseUrl;

  // Auth
  static const String login = Constants.login;
  static const String signUp = Constants.signUp;
  static const String logout = Constants.logout;
  static const String profile = Constants.profile;
  static const String refreshTokenApi = Constants.core;
  static const String verifyOtp = Constants.verifyOtp;
  static const String resentOtp = Constants.resentOtp;
  static const String forgetPasswordEndPoint = Constants.forgetPasswordEndPoint;
  static const String forgetOtp = Constants.forgetOtp;
  static const String resetPassword = Constants.resetPassword;
  static const String changePassword = Constants.changePassword;
  static const String changePhone = Constants.changePhone;
  static const String deleteAccount = Constants.deleteAccount;




  // Address
  static const String city = Constants.city;
  static const String region = Constants.region;
  static const String area = Constants.area;
  static const String userLocation = Constants.userLocation;
  static const String nearestLocation = Constants.nearestLocation;




  // Orders / Cart
  static const String appointments = Constants.appointments;
  static const String order = Constants.order;
    static const String postFcm = Constants.postFcm;

  static const String createOrder = Constants.createOrder;
  static const String acceptOrder = Constants.acceptOrder;
  static const String getCartItems = Constants.getCartItems;
  static const String postRequest = Constants.postRequest;
  static const String pendingAccepted = Constants.pendingAccepted;
  static const String confirmOrder = Constants.confirmOrder;
  static const String cancelOrder = Constants.cancelOrder;
  static const String cancelO = Constants.cancelO;
  static const String confirmO = Constants.confirmO;

  // Payment
  static const String payment = Constants.payment;
  static const String fawry = Constants.fawry;
  static const String fawryProcessPayment = Constants.fawryProcessPayment;
  static const String fawryMyPayments = Constants.fawryMyPayments;

  // Other
  static const String ads = Constants.ads;
  static const String contactUs = Constants.contactUs;
  static const String aboutUs = Constants.aboutUs;
  static const String notificationsCount = Constants.notificationsCount;

  // Remote Config values
  static String get googleMapsApiKey =>
      RemoteConfigService.getString('MAPS_API_KEY');
  static String get requiredMinimumAppBuild =>
      RemoteConfigService.getString('minimum_version');
  static String get recommendedMinimumAppBuild =>
      RemoteConfigService.getString('recommended_version');
}
