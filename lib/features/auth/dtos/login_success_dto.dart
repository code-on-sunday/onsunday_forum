class LoginSuccessDto {
  final String accessToken;

  const LoginSuccessDto({
    required this.accessToken,
  });

  factory LoginSuccessDto.fromJson(Map<String, dynamic> json) {
    return LoginSuccessDto(
      accessToken: json['access_token'] as String,
    );
  }
}
