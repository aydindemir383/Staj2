// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Gruplar extends StatefulWidget {
  @override
  Grup createState() => Grup();
}

class Grup extends State<Gruplar> {
  final FirebaseDatabase database = FirebaseDatabase();
  static String grupName = '';
  var gruplarList = [];

  Future myfuture() {
    database.reference().child('Ogrenciler/Gruplar').once().then((sp) {
      for (var i in sp.value.keys) {
        setState(() {
          gruplarList.add(i.toString());
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    myfuture();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gruplar',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gruplar'),
        ),
        body: Center(
            child: Column(
          children: [
            if(gruplarList.length==0)
            Text('Henüz herhangi bir Grup kurulmadı !!!!'),
            for (var i = 0; i < gruplarList.length; i++)
              
              Container(
                  width: 800,
                  height: 70,
                  color: Colors.blueGrey,
                  
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Colors.blueGrey,
                    child: Text(gruplarList[i],style: TextStyle(height: 1, fontSize: 30,color: Colors.white),),
                    textColor: Colors.red,
                    onPressed: () {
                      Navigator.pushNamed(context, '/ahmed');
                      grupName = gruplarList[i];
                    },
                  ),
                ),
              
          ],
        )),
      ),
    );
  }
}
