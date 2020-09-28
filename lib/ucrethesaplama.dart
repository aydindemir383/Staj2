// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UcretHesaplama extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Ucret();
  }
}

class Ucret extends State<UcretHesaplama> {
  final FirebaseDatabase database = FirebaseDatabase();
  final AdSoyad = TextEditingController();
  var g = 0;
  var son_sayi = 0;
  var total = 0;
  @override
  void initState() {
    g = 0;

    super.initState();
  }

  Future<void> Ucret_Heasbi(var OgrenciAdi) async {
    g = 0;
    await database
        .reference()
        .child('Ogrenciler/Ucretler/$OgrenciAdi')
        .once()
        .then((DataSnapshot sp) {
      var t = sp.value.keys;

      for (var i in t) {
        g = g + 1;
      }
      print('Derslerin sayisi === > ' + t.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ödencek Para Miktarı',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ödencek Para Miktarı'),
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 350,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: AdSoyad,
                        obscureText: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Öğrenci Ad Soyad ',
                            hintText: 'Öğrenci Ad Soyad'),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  if (AdSoyad.text.toString() != '')
                    Container(
                      color: Colors.deepPurple,
                      child: Text(
                          "Ödenecek Para Miktarı = " +
                              (total * 50).toString() +
                              "  TL",
                          style: TextStyle(
                              height: 3,
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  else
                    Container(
                      color: Colors.deepPurple,
                      child: Text("Lütfen Öğrenci Adını yazabilir misiniz !!!",
                          style: TextStyle(
                              height: 3,
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF6200EE),
                    child: Text('Ücreti Göster !!!'),
                    onPressed: () {
                      Ucret_Heasbi(AdSoyad.text.toString().trim().toLowerCase())
                          .then((value) {
                        setState(() {
                          son_sayi = g;
                        });
                      }).then((value) {
                        Text('son sayi ' + son_sayi.toString());
                        setState(() {
                          total = son_sayi;
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF6200EE),
                    onPressed: () {
                      // Respond to button press

                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Ödemek İçin ....'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Ödemek İster Misniz ؟؟؟'),
                                 
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Hayır ؟؟؟'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text('Evet ؟؟؟'),
                                onPressed: () {
                                  database
                                      .reference()
                                      .child
                                      ('Ogrenciler/Ucretler/${AdSoyad.text.toString().toLowerCase().trim()}')
                                      .remove();
                                       Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Borç Ödeme ؟؟؟'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
