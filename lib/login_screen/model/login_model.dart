class LoginModel {
  final int code;
  final bool success;
  final String status;
  final String message;
  final String accessToken;
  final String refreshToken;
  final String uniqueId;
  final String email;
  final String phone;
  final String userId;
  final String name;

  LoginModel({
    required this.code,
    required this.success,
    required this.status,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.uniqueId,
    required this.email,
    required this.phone,
    required this.userId,
    required this.name,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'] ?? 0,
      success: json['success'] ?? false,
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      uniqueId: json['unique_id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
