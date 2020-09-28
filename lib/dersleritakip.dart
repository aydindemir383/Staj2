// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:staj/Gruplar.dart';

class Dersleritakip extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Dersleri();
  }
}

class Dersleri extends State<Dersleritakip> {
  var ogrenciList = [];
  var scolor = [];
  final FirebaseDatabase database = FirebaseDatabase();
  Future myfuture() {
    database
        .reference()
        .child('Ogrenciler/Gruplar/${Grup.grupName}')
        .once()
        .then((sp) {
      var data = sp.value;
      for (var i in sp.value.keys) {
        setState(() {
          ogrenciList.add(data[i]['name']);
        });
      }
    }).then((value) {
      for (var i = 0; i < ogrenciList.length; i++) scolor.add(Colors.black45);
    });
  }

  Future<void> hazir() async {
    await myfuture();
  }

  @override
  void initState() {
    hazir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoklama ',
      home: Scaffold(
        appBar: AppBar(
          title: RaisedButton(
            child: Text('Ders Bittirmek ??'),
            onPressed: () {
              database
                  .reference()
                  .child('Ogrenciler/Gruplar/' + Grup.grupName)
                  .remove();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
        body: Center(
            child: Column(
          children: [
            for (var i = 0; i < ogrenciList.length; i++)
              Container(
                width: 800,
                height: 70,
                color: Colors.blueGrey,

                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  color: scolor[i],
                  child: Text(
                    ogrenciList[i],
                    style:
                        TextStyle(height: 1, fontSize: 30, color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      if (scolor[i] == Colors.black45) {
                        scolor[i] = Colors.cyan;
                        Fluttertoast.showToast(
                            msg: "${ogrenciList[i]} Var ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);

// ****************Add To data Base **************************//
                        database
                            .reference()
                            .child('Ogrenciler/Ucretler/' +
                                ogrenciList[i] 
                                
                                )
                            .push()
                            .set(Grup.grupName);
// *****************

                      } else {
                        scolor[i] = Colors.black45;
                        Fluttertoast.showToast(
                            msg: "${ogrenciList[i]} Yoktur ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        // ****************************************Delete from Database ******************************
                        database
                            .reference()
                            .child('Ogrenciler/Ucretler/' +
                                ogrenciList[i] +
                                '/' +
                                Grup.grupName)
                            .remove();
                        //******************************************** */
                      }
                    });
                  },
                ),

// **************************************************

// *********************************************************************
              ),
          ],
        )),
      ),
    );
  }
}
