import 'dart:convert';
import 'package:crypto_app/add_new_crypto.dart';
import 'package:crypto_app/favcrypto_list_model.dart';
import 'package:crypto_app/search_new_crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'crypto_value_model.dart';

Future<CryptoValue> fetchUSDValue() async {
  final response = await http
      .get(Uri.parse('https://api.cryptapi.io/btc/convert/?value=1&from=usd'));

  if (response.statusCode == 200) {
    return CryptoValue.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Fallo la conexion");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<CryptoValue> futureCryptoValue;

  @override
  void initState() {
    super.initState();
    futureCryptoValue = fetchUSDValue();
  }

  List<String> listOfCryptos = FavCryptos.singleton.favCryptosList.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cryptos"),
      ),
      body: Center(
        child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${listOfCryptos[index]}',
                      ),
                    ),
                    Container(
                      child: FutureBuilder<CryptoValue>(
                        future: futureCryptoValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.usdValue);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Container(
                      child: FloatingActionButton(
                          heroTag: Text("deleteCrypto"),
                          child: Icon(Icons.delete),
                          onPressed: null),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: FavCryptos.singleton.favCryptosList.length),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: Text("addCrypto"),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SecondRoute2()),
        ),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
