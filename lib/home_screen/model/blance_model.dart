class BalanceModel {
  final int code;
  final bool success;
  final String status;
  final String message;
  final List<Balance> balances;

  BalanceModel({
    required this.code,
    required this.success,
    required this.status,
    required this.message,
    required this.balances,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      code: json['code'] ?? 0,
      success: json['success'] ?? false,
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      balances:
          (json['balances'] as List<dynamic>?)
              ?.map((e) => Balance.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Balance {
  final int currency;
  final double balance;

  Balance({required this.currency, required this.balance});

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      currency: json['currency'] ?? 0,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
