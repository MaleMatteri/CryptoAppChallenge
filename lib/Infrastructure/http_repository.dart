import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto_app/Models/crypto_value_model.dart';
import 'package:crypto_app/Models/favcrypto_list_model.dart';

class HttpRepository {
  static Future<CryptoValue> fetchUSDValue(String cryptoName) async {
    var response = await http.get(Uri.parse('https://api.cryptapi.io/' +
        cryptoName +
        '/convert/?value=1&from=usd'));
    if (response.statusCode == 200) {
      return CryptoValue.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fallo la conexion");
    }
  }

  static Future<List<CryptoValue>> fetchAllUSDValues() {
    List<String> cryptoNames = FavCryptos.singleton.favCryptosList.toList();
    var mapCrypto = cryptoNames.map((e) => fetchUSDValue(e)).toList();
    final values = Future.wait(mapCrypto);
    return values;
  }
}
