// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Randevualmak extends StatefulWidget {
  @override
  Randevu createState() => Randevu();
}

class Randevu extends State<Randevualmak> {
  @override
  Widget build(BuildContext context) {
    final adSoyad = TextEditingController();
    final tC = TextEditingController();
    final grupNo = TextEditingController();
    var it = "";
    var tt = 0;
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      adSoyad.dispose();
      tC.dispose();
      super.dispose();
    }

    @override
    void initState() {
      setState(() {
        it = '';
        tt = 0;
      });
    }

    return MaterialApp(
      title: 'Randevu Almak',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Randevu Almak'),
        ),
        body: ListView(
          children: <Widget>[
            Column(children: [
              SizedBox(
                width: 50.0,
                height: 50.0,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: adSoyad,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Öğrenci Adı',
                        hintText: 'Ad soyad'),
                  )),
// *******************
              SizedBox(
                width: 50.0,
                height: 40.0,
              ),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 350,
                  child: TextField(
                    maxLength: 11,
                    controller: tC,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'TC Kimlik Numarası',
                        hintText: 'TC Numarası'),
                  )),

// *******************

              SizedBox(
                width: 50.0,
                height: 20.0,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 350,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: grupNo,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ders Adı (Grup Numarası )',
                        hintText: 'Ders Adı (Grup Numarası )'),
                  )),

//********************** */
              SizedBox(
                width: 50.0,
                height: 70.0,
              ),
              Container(
                  height: 70,
                  width: 250,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF6200EE),
                    onPressed: () {
                      print('Her Sey ===> ' + adSoyad.text + ' ' + tC.text);

                      final FirebaseDatabase database = FirebaseDatabase();
                      var messagesRef =
                          database.reference().child('Ogrenciler');

                      print(it);
                      var kdonem;

                      messagesRef.once().then((DataSnapshot sp) {
                        setState(() {
                          kdonem = sp.value.keys;
                        });
                        for (var i in kdonem) {
                          print(kdonem.length);
                          if (i.toString().trim() ==
                              tC.text.toString().trim()) {
                            // print('i of nnnnnnnnnnnnnn    ' + i.toString());

                            database
                                .reference()
                                .child('Ogrenciler/Gruplar/' +
                                    grupNo.text.toString() +
                                    '/' +
                                    tC.text.toString())
                                .set({
                              'name': '${adSoyad.text.toString()}'
                            }).then((value) {

                              

                            });
                            // *********************************************************
                            setState(() {
                              tt = 1;
                            });
                          }
                        }
                      }).then((value) {
                        if (tt == 1) {
                          Fluttertoast.showToast(
                              msg: "Randevu alındı !!!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (tt == 0) {
                          Fluttertoast.showToast(
                              msg: "Kayıt Bulunmadı !!!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      });
                    },
                    child: Text('Randevu Al'),
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
