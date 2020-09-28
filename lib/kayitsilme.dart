// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
// void main() => runApp(MyApp());

class Kayitsilme extends StatefulWidget {
  @override
  Kayits createState() => Kayits();
}

class Kayits extends State<Kayitsilme> {
  final tC = TextEditingController();
  var r;
  @override
  void initState() {
    r = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kayıt Silme',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kayıt Silme'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 350,
                child: TextField(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  controller: tC,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'TC Numarası',
                      hintText: 'TC Numarası'),
                )),
            SizedBox(
              height: 50,
            ),
            Container(
                height: 70,
                width: 250,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xFF6200EE),
                  onPressed: () {
// **************************************************

                    // ********************************************
                    final FirebaseDatabase database = FirebaseDatabase();

                    if (tC.text.toString().length == 11) {
                      database
                          .reference()
                          .child('Ogrenciler/' + tC.text.toString())
                          .remove();

                      DatabaseReference ref2 = FirebaseDatabase.instance
                          .reference()
                          .child("Ogrenciler/Gruplar");
                      ref2.once().then((DataSnapshot sp) {
                        //  print('keys ahmed ' + sp.value.keys);
                        setState(() {
                            r = sp.value.keys;
                        });
                       
                        for (var t in r) {
                         if (t != null)
                          {
                           
                            print(t);

                           database
                              .reference()
                              .child('Ogrenciler/Gruplar/${t.toString()}/' + tC.text.toString())
                              .remove();


                          }

                          
                        }
                      }).then((value) => {
                            Fluttertoast.showToast(
                                msg: "Silme İşleme Oldu",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0),
                          });
                    }
                  },
                  child: Text('Kayıt Silme'),
                )),
          ],
        ),
      ),
    );
  }
}
