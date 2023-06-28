import 'dart:convert';

import 'package:basketbol/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Api>(
          future: getCall(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("DÖNGÜYE GİRDİ");
              if (snapshot.hasData) {
                print("USERNAME GÖSTERLİYO");
                return Text(snapshot.data!.username);
              } else {
                print("VERİ ÇEKİLEMDİ");
                return Text("VERİ ÇEKİLEMEDİ");
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print("WWATİNG");
              return CircularProgressIndicator();
            } else {
              print("not found");
              return Text("APİYE ULASİLMİYO");
            }
          },
        ),
      ),
    );
  }

  Future<Api> getCall() async {
    final apiurl =
        "https://hwasampleapi.firebaseio.com/api/books/0/author.json";
    final response = await http.get(Uri.parse(apiurl));
    if (response.statusCode == 200) {
      print(response.statusCode == 200);
      return Api.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw Exception("NOT FOUND");
    }
  }
}
