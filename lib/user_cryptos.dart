import 'dart:convert';
import 'package:crypto_app/favcrypto_list_model.dart';
import 'package:crypto_app/search_new_crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'crypto_value_model.dart';

Future<CryptoValue> fetchUSDValue(String cryptoName) async {
  var response = await http.get(Uri.parse(
      'https://api.cryptapi.io/' + cryptoName + '/convert/?value=1&from=usd'));
  if (response.statusCode == 200) {
    return CryptoValue.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Fallo la conexion");
  }
}

Future<List<CryptoValue>> fetchAllUSDValues() {
  List<String> cryptoNames = FavCryptos.singleton.favCryptosList.toList();
  var mapCrypto = cryptoNames.map((e) => fetchUSDValue(e)).toList();
  final values = Future.wait(mapCrypto);
  return values;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void deleteElement(int index) {
    setState(() {
      var objetoELiminado = listOfCryptos.removeAt(index);
      FavCryptos.singleton.favCryptosList.remove(objetoELiminado);
    });
  }

  late Future<List<CryptoValue>> futureCryptoValue;

  @override
  void initState() {
    super.initState();
    futureCryptoValue = fetchAllUSDValues();
  }

  List<String> listOfCryptos = FavCryptos.singleton.favCryptosList.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cryptos"),
      ),
      body: ListView.builder(
          itemCount: listOfCryptos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: Text(
                  listOfCryptos[index],
                ),
                trailing: FloatingActionButton(
                  heroTag: index,
                  mini: true,
                  child: Icon(
                    Icons.delete,
                  ),
                  onPressed: () => deleteElement(index),
                ),
                title: FutureBuilder<List<CryptoValue>>(
                  future: futureCryptoValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "USD " + snapshot.data![index].usdValue,
                        textAlign: TextAlign.center,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const LinearProgressIndicator();
                  },
                ));
          }),
      floatingActionButton: FloatingActionButton(
        heroTag: const Text("addCrypto"),
        onPressed: () => {
          print(ModalRoute.of(context)),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SecondRoute2(),
                fullscreenDialog: true),
          ).then((value) => setState(() {
                listOfCryptos = FavCryptos.singleton.favCryptosList.toList();
                futureCryptoValue = fetchAllUSDValues();
              })),
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
