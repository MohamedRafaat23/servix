import 'package:servix/core/utils/constants/app_enums.dart';
import 'package:servix/core/utils/functions/callback_token.dart';
import 'package:servix/core/di/service_locator.dart';
import 'package:servix/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUseCase {
  CheckAuthStatusUseCase(AuthRepository authRepository);

  Future<bool> call() async {
    final accessToken = await sl<HandleMulticallLocal>().getLocalData(
      keyType: LocalEnumKey.accessToken,
    );
    return accessToken != null && accessToken.isNotEmpty;
  }
}