import 'dart:ui';
import 'crypto_search_list.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchWidget(title: "Search for a new crypto"),
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  //Lista de cryptos, TEMPORAL
  static List<CryptoSearchListModel> cryptos_available_list = [
    CryptoSearchListModel("Bitcoin", "BTC", 3.14),
    CryptoSearchListModel("Ethereum", "ETH", 3.14),
    CryptoSearchListModel("Tether", "USDT", 3.14),
    CryptoSearchListModel("Binance Coin", "BNB", 3.14),
    CryptoSearchListModel("Dai", "DAI", 3.14),
    CryptoSearchListModel("PancakeSwap", "CAKE", 3.14),
  ];

  List<CryptoSearchListModel> display_list = List.from(cryptos_available_list);

  //Funcion que filtra la lista
  void filterList(String searchTerm) {
    var newList = cryptos_available_list
        .where((element) => element.crypto_name!
            .toLowerCase()
            .contains(searchTerm.toLowerCase()))
        .toList();

    setState(() {
      display_list = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back'),
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.transparent),
        ),
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (searchTerm) => filterList(searchTerm),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "eg: Ethereum",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: display_list.length == 0
                  ? Center(
                      child: Text(
                      "No results were found",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ))
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                          display_list[index].crypto_name!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          display_list[index].cypto_abbreviation!,
                        ),
                        trailing: Text(
                            'USD ${display_list[index].usd_crypto_value!}'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
