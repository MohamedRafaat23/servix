enum RouterType {
  goName,
  pushName,
  replacementName,
  pushReplacementNamed,
  goAndPopAll,
}

enum RequestStatus { init, loading, success, failed }

enum RequestStatusType {
  pending,
  accepted,
  confirmed,
  paid,
  reject,
  inProgress,
  completed,
  cancelled,
  refunded,
}


enum OtpVerifyType {
  register,
  forgetPassword,
  updatemail,
  activeAccount;

  static OtpVerifyType fromString(String? value) {
    if (value == OtpVerifyType.register.nameStr) return OtpVerifyType.register;
    if (value == OtpVerifyType.forgetPassword.nameStr) {
      return OtpVerifyType.forgetPassword;
    }
    if (value == OtpVerifyType.updatemail.nameStr) {
      return OtpVerifyType.updatemail;
    }
    if (value == OtpVerifyType.activeAccount.nameStr) {
      return OtpVerifyType.activeAccount;
    }
    return OtpVerifyType.forgetPassword; // Default
  }

  String get nameStr {
    return switch (this) {
      OtpVerifyType.register => 'register',
      OtpVerifyType.forgetPassword => 'forgetPassword',
      OtpVerifyType.updatemail => 'updatemail',
      OtpVerifyType.activeAccount => 'activeAccount',
    };
  }
}

enum VerifyType { forgetPassword, register, verifyEmailUpdate, verifyPhone }

enum LocalEnumKey {
  accessToken,
  refreshToken,
  userId,
  gender,
  birthDate,
  fullName,
  phone,
  languageCode,
  role,
}

enum ToastStates { success, warning, error, info }

enum MedicalTestType { xRay, analysis, otherTests }
