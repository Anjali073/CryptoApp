import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crypto App",
      color: Colors.pink[300],
      theme:
          ThemeData(primarySwatch: Colors.pink, brightness: Brightness.light),
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "CryptoApp",
              textDirection: TextDirection.ltr,
            ),
            centerTitle: true,
          ),
          body: Screen1()),
    );
  }
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final Uri url = Uri.parse('https://api.coincap.io/v2/assets');

  var map;
  List currency = [];
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<List> getdata() async {
    http.Response data = await http.get(url);
    setState(() {
      map = json.decode(data.body);
      currency = map["data"];
    });
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 0,40,0),
              width: 450,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
              height: 200,
              width: 300,
              
              child: Card(
                elevation: 7,
                color: Colors.pink[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Name: " + currency[index]['name'],style: TextStyle(fontSize: 22),),
                    Text("Id: " + currency[index]['id'],style: TextStyle(fontSize: 22),),
                    Text("Symbol: " + currency[index]['symbol'],style: TextStyle(fontSize: 22),),
                    Text("Price :" + currency[index]['priceUsd'],style: TextStyle(fontSize: 22),),
                  ],
                ),
              ));
        },
        itemCount: currency == null ? 0 : currency.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}
