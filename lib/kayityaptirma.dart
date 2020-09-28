// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

// void main() => runApp(MyApp());
class Kayityaptirma extends StatefulWidget {
  @override
  Kayit createState() => Kayit();
}

class Kayit extends State<Kayityaptirma> {
  @override
  Widget build(BuildContext context) {
    final adSoyad = TextEditingController();
    final tC = TextEditingController();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      adSoyad.dispose();
      tC.dispose();
      super.dispose();
    }

    return MaterialApp(
      title: 'Kayıt Yaptırma',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kayıt Yaptırma'),
        ),
        body: ListView(
          children: <Widget>[
            Column(children: [
              SizedBox(
                width: 50.0,
                height: 100.0,
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
                height: 70.0,
              ),
              Container(
                  height: 70,
                  width: 250,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF6200EE),
                    onPressed: () {
                      print(adSoyad.text + ' ' + tC.text);
                      

                      final FirebaseDatabase database = FirebaseDatabase();
                      var messagesRef = database
                          .reference()
                          .child('Ogrenciler/' + tC.text.toString());
                      if (adSoyad.text.toString().length > 0 &&
                          tC.text.toString().length == 11) {
                        messagesRef
                            .set(adSoyad.text.toString())
                            .then((value) => {
                              Fluttertoast.showToast(
        msg: "Giriş İşleme Oldu",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    ),
                            });
                      } else {
//********************************************* */

                        showDialog<void>(
                          context: context,
                          barrierDismissible: true, // user must not tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Hata!!!'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    if (adSoyad.text.toString().length == 0 ||
                                        tC.text.toString().length == 0)
                                      Text('Boş Bir Alan Bırakmazsınız !!!!.'),
                                    if (tC.text.toString().length > 0 &&
                                        tC.text.toString().length < 11)
                                      Text('TC kimlik numarası 11 haneli !!!!.')
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Çıkış'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );

// *************************************************

                      }
                    },
                    child: Text('Kayıt Yaptırma'),
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
