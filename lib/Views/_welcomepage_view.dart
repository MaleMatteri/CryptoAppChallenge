import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('My_crypto_fav.png'),
            ),
            Hero(
              tag: Text("screen1"),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/homescreen');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 60),
                ),
                icon: Icon(Icons.login, size: 25),
                label: Text("Log in", style: TextStyle(fontSize: 20.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
