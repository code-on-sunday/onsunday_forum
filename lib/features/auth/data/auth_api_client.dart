import 'package:dio/dio.dart';
import 'package:onsunday_forum/features/auth/dtos/login_dto.dart';
import 'package:onsunday_forum/features/auth/dtos/login_success_dto.dart';

class AuthApiClient {
  AuthApiClient(this.dio);

  final Dio dio;

  Future<LoginSuccessDto> login(LoginDto loginDto) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': loginDto.username,
          'password': loginDto.password,
        },
      );
      return LoginSuccessDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
