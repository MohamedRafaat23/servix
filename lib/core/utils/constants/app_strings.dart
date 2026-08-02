import '../functions/translation.dart';

class AppStrings {
  static const String appName = "Servix";

  // Common
  static String get save => "save".trans;
  static String get cancel => "cancel".trans;
  static String get yes => "yes".trans;
  static String get no => "no".trans;
  static String get search => "search".trans;
  static String get seeAll => "see_all".trans;
  static String get retry => "retry".trans;
  static String get loading => "loading".trans;
  static String get somethingWentWrong => "something_went_wrong".trans;
  static String get noInternet => "no_internet".trans;
  static String get connectionError => "connection_error".trans;
  static String get optional => "optional".trans;
  static String get unknownError => "unknownError".trans;
  //onbording
static String get onBoardingTitle1 => "on_boarding_title_1".trans;
static String get onBoardingTitle2 => "on_boarding_title_2".trans;
static String get onBoardingTitle3 => "on_boarding_title_3".trans;

static String get onBoardingDesc1 => "on_boarding_desc_1".trans;
static String get onBoardingDesc2 => "on_boarding_desc_2".trans;
static String get onBoardingDesc3 => "on_boarding_desc_3".trans;

static String get onboardingGetStarted => "onboarding_get_started".trans;
static String get skip => "skip".trans;
static String get next => "next".trans;



  // Auth
  static String get login => "login".trans;
  static String get signUp => "sign_up".trans;
  static String get email => "email".trans;
  static String get emailAddress => "email_address".trans;
  static String get password => "password".trans;
  static String get enterYourEmail => "enter_your_email".trans;
  static String get enterYourEmailOrNumber => "enter_your_email_or_number".trans;
  static String get enterYourPassword => "enter_your_password".trans;
  static String get send => "send".trans;
  static String get submit => "submit".trans;
  static String get passwordsMustMatch => "passwordsMustMatch".trans;
  static String get resetPassword => "reset_password".trans;
  static String get invalidEmailOrNumber => "invalid_email_or_number".trans;
  static String get invalidEmail => "invalid_email".trans;
  static String get passwordMinLength => "password_min_length".trans;
  static String get forgotPassword => "forgot_password".trans;
  static String get dontHaveAccount => "dont_have_account".trans;
  static String get alreadyHaveAccount => "already_have_account".trans;
  static String get fullName => "full_name".trans;
  static String get nameRequired => "name_required".trans;
  static String get phoneNumber => "phone_number".trans;
  static String get phoneRequired => "phone_required".trans;
  static String get city => "city".trans;
  static String get cityRequired => "city_required".trans;
  static String get country => "country".trans;
  static String get countryRequired => "country_required".trans;
  static String get streetAddress => "street_address".trans;
  static String get streetAddressRequired => "street_address_required".trans;

  static String get enterYourNewPassword => "enter_your_new_password".trans;
  //
  static String get otpVerification => "otp_verification".trans;
  static String get resendCode => "resend_code".trans;
  static String get dontReceiveCode => "dont_receive_code".trans;
  static String get verifyOtp => "verify_otp".trans;

  // Navbar
  static String get home => "home".trans;
  static String get orders => "orders".trans;
  static String get favorite => "favorite".trans;
  static String get account => "account".trans;

  // Home screen
  static String hiUser(String name) =>
      "hi_user".trans.replaceAll("{name}", name);
  static String get searchServicesHint => "search_services_hint".trans;
  static String get promoHomeCleaningTitle => "promo_home_cleaning_title".trans;
  static String get promoHomeCleaningDesc => "promo_home_cleaning_desc".trans;
  static String get bookNow => "book_now".trans;
  static String get categories => "categories".trans;
  static String get nearbyProfessionals => "nearby_professionals".trans;
  static String get failedToLoadFavorites=>"failed_to_loadFavorites".trans;
  static String get failedToLoadOrders=>"failed_to_loadOrders".trans;
  static String get failedToLoadServices=>"failed_to_loadServices".trans;
  static String get noFavorites=>"no_favorites".trans;
  static String get noOrders=>"no_orders".trans;
  static String get noServices=>"no_services".trans;
  static String get noData=>"no_data".trans;
  static String get perHour=>"per_hour".trans;
  static String get tapToFavorite => "tap_to_favorite".trans;
  static String get tapToUnfavorite => "tap_to_unfavorite".trans;
  static String get tapTheHeartIconOnAnyProfessionalOrServiceToAddThemTOYourFav => "tap_the_heart_icon".trans;

  // Service categories
  static String get plumbing => "plumbing".trans;
  static String get electrical => "electrical".trans;
  static String get blacksmith => "blacksmith".trans;
  static String get carpentry => "carpentry".trans;
  static String get mechanical => "mechanical".trans;
  static String get construction => "construction".trans;

  // Orders
  static String get ordersTitle => "orders_title".trans;
  static String get all => "all".trans;
  static String get pending => "pending".trans;
  static String get completed => "completed".trans;
  static String get cancelled => "cancelled".trans;
  static String get orderDetails => "order_details".trans;
  static String get details => "details".trans;
  static String get service => "service".trans;
  static String get address => "address".trans;
  static String get date => "date".trans;
  static String get baseRate => "base_rate".trans;
  static String get serviceFee => "service_fee".trans;
  static String get total => "total".trans;
  static String get orderStatus => "order_status".trans;
  static String get bookingConfirmed => "booking_confirmed".trans;
  static String get onTheWay => "on_the_way".trans;
  static String get arrived => "arrived".trans;
  static String get startWorked => "start_worked".trans;
  static String get payment => "payment".trans;
  static String get contact => "contact".trans;
  static String get reorder => "reorder".trans;
  static String get workerCouldNotReachAddress =>
      "worker_could_not_reach_address".trans;

  // Validation
  static String get emailErrorEmpty => "email_error_empty".trans;
  static String get emailNotValid => "email_not_valid".trans;
  static String get passwordErrorEmpty => "password_error_empty".trans;
  static String get password8Characters => "password_8_characters".trans;
  static String get leastOneNumber => "least_one_number".trans;
  static String get passwordErrorUppercase => "password_error_uppercase".trans;
  static String get passwordErrorLowercase => "password_error_lowercase".trans;
  static String get passwordErrorSpecial => "password_error_special".trans;
  static String get canNotBeEmpty => "can_not_be_empty".trans;
  static String get otpInvalid => "otp_invalid".trans;
  static String get invalidNumber => "invalid_number".trans;
  static String get numberRequired => "number_required".trans;

  // Login required widget
  static String get loginRequiredTitle => "login_required_title".trans;
  static String get loginRequiredSubtitle => "login_required_subtitle".trans;
  static String get maybeLater => "maybe_later".trans;

  // Search
  static String get searchHint => "search_hint".trans;

  // OTP extra
  static String otpSentMessage(String identifier) =>
      "otp_sent_message".trans.replaceAll("{identifier}", identifier);    

  // Profile
  static String get profile => "profile".trans;
  static String get accountSection => "account_section".trans;
  static String get personalInformation => "personal_information".trans;
  static String get savedAddresses => "saved_addresses".trans;
  static String get changePasswordLabel => "change_password".trans;
  static String get settingsSection => "settings_section".trans;
  static String get language => "language".trans;
  static String get notifications => "notifications".trans;

  // Personal information screen
  static String get enterYourFullName => "enter_your_full_name".trans;

  // Saved addresses
  static String get addNewAddress => "add_new_address".trans;
  static String get setLocationInMap => "set_location_in_map".trans;
  static String get chooseCountry => "choose_country".trans;
  static String get chooseCity => "choose_city".trans;
  static String get area => "area".trans;
  static String get writeArea => "write_area".trans;
  static String get streetName => "street_name".trans;
  static String get writeStreetName => "write_street_name".trans;
  static String get buildingNumber => "building_number".trans;
  static String get writeBuildingNumber => "write_building_number".trans;
  static String get floorNumber => "floor_number".trans;
  static String get writeFloorNumber => "write_floor_number".trans;
  static String get apartmentNumber => "apartment_number".trans;
  static String get writeApartmentNumber => "write_apartment_number".trans;

  // Change password screen
  static String get oldPassword => "old_password".trans;
  static String get enterYourOldPassword => "enter_your_old_password".trans;
  static String get newPassword => "new_password".trans;
  static String get confirmPassword => "confirm_password".trans;
  static String get confirmYourPassword => "confirm_your_password".trans;

  // Language screen
  static String get arabicLanguage => "arabic_language".trans;
  static String get englishLanguage => "english_language".trans;

  // Delete account dialog
  static String get deleteAccountConfirmTitle =>
      "delete_account_confirm_title".trans;
  static String get deleteAccountConfirmMessage =>
      "delete_account_confirm_message".trans;

   //services
   static String get services => "services".trans;
  static String get allservices => "all_services".trans;
  static String get topProfessionals => "top_professionals".trans;
  static String get searchProfessionals => "searchProfessionals".trans;
  static String get about => "about".trans;
  static String get reviews => "reviews".trans;
  static  String jobs = 'Jobs';
  static  String get experience => "Experience".trans;
  static  String get serviceArea => 'Service Area'.trans;
}