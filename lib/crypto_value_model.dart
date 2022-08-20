class CryptoValue {
  var usdValue = "";

  CryptoValue({
    required this.usdValue,
  });

  factory CryptoValue.fromJson(Map<String, dynamic> json) {
    return CryptoValue(
      usdValue: json['exchange_rate'],
    );
  }
}
