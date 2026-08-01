class Constants {
  // Base
  static const String baseUrl = 'https://your-api-domain.com/api/'; // ⚠️ حط الدومين الحقيقي بتاعك هنا

  // Headers
  static const String acceptLanguage = 'Accept-Language';
  static const String arCode = 'ar';

  // Auth
  static const String login = 'auth/login/';
  static const String signUp = 'auth/register/';
  static const String logout = 'auth/logout/';
  static const String profile = 'auth/profile/';
  static const String core = 'auth/token/refresh/';
  static const String verifyOtp = 'auth/verify-otp/';
  static const String resentOtp = 'auth/resend-otp/';
  static const String forgetPasswordEndPoint = 'auth/forget-password/';
  static const String forgetOtp = 'auth/forget-password/verify-otp/';
  static const String resetPassword = 'auth/reset-password/';
  static const String changePassword = 'auth/change-password/';
  static const String changePhone = 'auth/change-phone/';
  static const String deleteAccount = 'auth/delete-account/';

  // Address
  static const String city = 'address/city/';
  static const String region = 'address/region/';
  static const String area = 'address/area/';
  static const String userLocation = 'address/user-location/';
  static const String nearestLocation = 'address/nearest-location/';

  // Orders / Cart
  static const String appointments = 'orders/appointments/';
  static const String order = 'orders/';
  static const String createOrder = 'orders/create/';
  static const String acceptOrder = 'orders/accept/';
  static const String getCartItems = 'cart/items/';
  static const String postRequest = 'orders/request/';
  static const String pendingAccepted = 'orders/pending-accepted/';
  static const String confirmOrder = 'orders/confirm/';
  static const String cancelOrder = 'orders/cancel/';
  static const String cancelO = 'orders/cancel-o/';
  static const String confirmO = 'orders/confirm-o/';
    static const String postFcm = 'orders/postFcm-o/';


  // Payment
  static const String payment = 'payment/';
  static const String fawry = 'payment/fawry/';
  static const String fawryProcessPayment = 'payment/fawry/process/';
  static const String fawryMyPayments = 'payment/fawry/my-payments/';

  // Other
  static const String ads = 'ads/';
  static const String contactUs = 'contact-us/';
  static const String aboutUs = 'about-us/';
  static const String notificationsCount = 'notifications/count/';
}