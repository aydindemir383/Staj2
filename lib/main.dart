import 'package:flutter/material.dart';
import 'package:staj/Gruplar.dart';
import 'package:staj/dersleritakip.dart';
import 'package:staj/randevualmak.dart';
import 'package:staj/ucrethesaplama.dart';
import 'Kayitsilme.dart';
import 'kayityaptirma.dart';
void main() {

runApp(MaterialApp(
    // home: MyApp2(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
     '/': (BuildContext context) => MyApp(),
      '/Kayityaptirma': (BuildContext context) => Kayityaptirma(),
      
      '/Kayitsilme': (BuildContext context) => Kayitsilme(),
       '/Dersleritakip': (BuildContext context) => Gruplar(),
         '/Randevualmak': (BuildContext context) => Randevualmak(),
        '/ahmed': (BuildContext context) => Dersleritakip(),
          '/Ucretler': (BuildContext context) => UcretHesaplama(),
      
    },
  ));
   
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staj',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Staj'),
        ),
        body:
        ListView(

      
        children:[

         Column(
          children: [
            SizedBox(
              width: 100.0,
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.all(0),
              width: 800,
              height: 70,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF6200EE),
                onPressed: () {
                 Navigator.pushNamed(context, '/Kayityaptirma');
                },
                child: Text('Kayıt Yaptırma'),
              ),
            ),

            //  *********************************

            SizedBox(
              width: 50.0,
              height: 50.0,
            ),
//

            Container(
              margin: EdgeInsets.all(0),
              width: 800,
              height: 70,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF6200EE),
                onPressed: () {
                  Navigator.pushNamed(context, '/Kayitsilme');
                },
                child: Text('Kayıt Silme'),
              ),
            ),

            SizedBox(
              width: 50.0,
              height: 50.0,
            ),

// ***************************************************

            Container(
              margin: EdgeInsets.all(0),
              width: 800,
              height: 70,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF6200EE),
                onPressed: () {
                   Navigator.pushNamed(context, '/Dersleritakip');
                },
                child: Text('Dersleri Takip Etme'),
              ),
            ),

// **************************************************

  SizedBox(
              width: 50.0,
              height: 50.0,
            ),

// ***************************************************

            Container(
              margin: EdgeInsets.all(0),
              width: 800,
              height: 70,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF6200EE),
                onPressed: () {
                   Navigator.pushNamed(context, '/Randevualmak');
                },
                child: Text('Randevu Almak'),
              ),
            ),


// ******************************************************
SizedBox(
height: 40,
)
,
 Container(
              margin: EdgeInsets.only(left: 0,right: 0),
              width: 800,
              height: 70,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF6200EE),
                onPressed: () {
                   Navigator.pushNamed(context, '/Ucretler');
                },
                child: Text('Ücretler Hesaplama'),
              ),
            ),

// *********************************************


          ],

// **********************************
        ),
        ],
          ),
      ),
    );
  }
}
