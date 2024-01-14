import 'dart:developer';

import 'package:onsunday_forum/features/auth/data/auth_api_client.dart';
import 'package:onsunday_forum/features/auth/data/auth_local_data_source.dart';
import 'package:onsunday_forum/features/auth/dtos/login_dto.dart';
import 'package:onsunday_forum/features/result_type.dart';

class AuthRepository {
  final AuthApiClient authApiClient;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepository({
    required this.authApiClient,
    required this.authLocalDataSource,
  });

  Future<Result<void>> login({
    required String username,
    required String password,
  }) async {
    try {
      final loginSuccessDto = await authApiClient.login(
        LoginDto(username: username, password: password),
      );
      await authLocalDataSource.saveToken(loginSuccessDto.accessToken);
    } catch (e) {
      log('$e');
      return Failure('$e');
    }
    return Success(null);
  }
}
