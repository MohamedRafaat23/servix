import '../../network/end_points.dart';
import '../../network/api_consumer.dart';
import '../../utils/constants/storage_keys.dart';
import '../../utils/functions/common_fun.dart';
import '../../utils/functions/preference_utils.dart';
import '../../di/service_locator.dart';
import 'model/post_fcm_request.dart';

Future<void> postFcmMethod({required PostFcmRequestModel model}) async {
  try {
    final response = await sl.get<ApiConsumer>().post(
      EndPoints.postFcm,
      body: model.toJson(),
    );
    await response.fold(
      (failResponse) {
        appToast(failResponse);
      },
      (successResponse) async {
        await sl<PreferenceUtils>().setBool(StorageKeys.postFcmKey, true);
      },
    );
  } catch (e) {
    // Show error message
    appToast(e.toString());
  }
}
