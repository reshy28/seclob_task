class UserDetailsModel {
  final int code;
  final bool success;
  final String status;
  final String message;
  final UserData? data;

  UserDetailsModel({
    required this.code,
    required this.success,
    required this.status,
    required this.message,
    this.data,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      code: json['code'] ?? 0,
      success: json['success'] ?? false,
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String id;
  final String uniqueId;
  final String name;
  final String email;
  final String phone;
  final String country;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final Address? address;

  UserData({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    this.createdAt,
    this.updatedAt,
    required this.v,
    this.address,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? '',
      uniqueId: json['unique_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      v: json['__v'] ?? 0,
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
    );
  }
}

class Address {
  final String country;
  final String state;
  final String district;
  final String city;
  final String zip;

  Address({
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      city: json['city'] ?? '',
      zip: json['zip'] ?? '',
    );
  }
}
