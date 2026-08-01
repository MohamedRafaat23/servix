class PostFcmRequestModel {
  String? registrationId;
  String? type; // android, web, ios

  PostFcmRequestModel({
    this.registrationId,
    this.type,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registration_id'] = registrationId;
    data['type'] = type;
    return data;
  }
}
