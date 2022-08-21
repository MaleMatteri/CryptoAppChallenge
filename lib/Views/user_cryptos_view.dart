import 'dart:convert';
import 'package:crypto_app/Infrastructure/http_repository.dart';
import 'package:crypto_app/Models/favcrypto_list_model.dart';
import 'package:crypto_app/Views/search_new_crypto_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/crypto_value_model.dart';

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
    futureCryptoValue = HttpRepository.fetchAllUSDValues();
  }

  List<String> listOfCryptos = FavCryptos.singleton.favCryptosList.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My cryptos"),
      ),
      body: Column(
        children: [
          Expanded(
            child: listOfCryptos.length == 0
                ? const Center(
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Mmm... this looks empty! Add some cryptos with the '+' button",
                          style: TextStyle(fontSize: 17.0, color: Colors.grey),
                        )),
                  )
                : ListView.builder(
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: const Text("addCrypto"),
        onPressed: () => {
          print(ModalRoute.of(context)),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SearchNewCryptoView(),
                fullscreenDialog: true),
          ).then((value) => setState(() {
                listOfCryptos = FavCryptos.singleton.favCryptosList.toList();
                futureCryptoValue = HttpRepository.fetchAllUSDValues();
              })),
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
