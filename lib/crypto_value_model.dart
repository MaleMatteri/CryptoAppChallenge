class CryptoValue {
  final String usdValue;

  const CryptoValue({
    required this.usdValue,
  });

  factory CryptoValue.fromJson(Map<String, dynamic> json) {
    return CryptoValue(
      usdValue: json['exchange_rate'],
    );
  }
}
