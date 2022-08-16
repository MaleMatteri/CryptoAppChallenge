import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'crypto_search_list.dart';

class ThridRoute extends StatelessWidget {
  const ThridRoute({Key? key}) : super(key: key);

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
              "NombreDeLaCrypto",
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
            ElevatedButton.icon(
              onPressed: () {
                // Respond to button press
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 60),
              ),
              icon: Icon(Icons.save, size: 25),
              label: Text("Save", style: TextStyle(fontSize: 20.0)),
            )
          ],
        ),
      ),
    );
  }
}
