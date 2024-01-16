import 'package:dio/dio.dart';
import 'package:onsunday_forum/features/auth/dtos/login_dto.dart';
import 'package:onsunday_forum/features/auth/dtos/login_success_dto.dart';
import 'package:onsunday_forum/features/auth/dtos/register_dto.dart';

class AuthApiClient {
  AuthApiClient(this.dio);

  final Dio dio;

  Future<LoginSuccessDto> login(LoginDto loginDto) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: loginDto.toJson(),
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

  Future<void> register(RegisterDto registerDto) async {
    try {
      await dio.post(
        '/auth/register',
        data: registerDto.toJson(),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
