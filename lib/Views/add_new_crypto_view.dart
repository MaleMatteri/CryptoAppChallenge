import 'package:crypto_app/Models/favcrypto_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddNewCryptoView extends StatelessWidget {
  const AddNewCryptoView({Key? key, required this.cryptoName})
      : super(key: key);

  final String cryptoName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new fav crypto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              cryptoName,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter the quantity",
                prefixIcon: Icon(Icons.paid),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: Text("screen3"),
              child: ElevatedButton.icon(
                onPressed: () {
                  FavCryptos.singleton.favCryptosList.add(cryptoName);
                  Navigator.popUntil(
                      context, ModalRoute.withName('/homescreen'));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 60),
                ),
                icon: Icon(Icons.save, size: 25),
                label: Text("Save", style: TextStyle(fontSize: 20.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
