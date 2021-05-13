//
//
//import 'package:flutter/material.dart';
//
//class ButtonWidget extends StatelessWidget {
//  final String text;
//  final VoidCallback onClicked;
//
//  const ButtonWidget({
//    @required this.text,
//    @required this.onClicked,
//    Key key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) => RaisedButton(
//        child: Text(
//          text,
//          style: TextStyle(fontSize: 24, color: Colors.white),
//        ),
//        shape: StadiumBorder(),
//        color: Color(0XFFffc107),
//        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//        textColor: Colors.white,
//        onPressed: onClicked,
//      );
//}
//
///*
//
//Container(
//              alignment: Alignment.centerRight,
//              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//              child: RaisedButton(
//                onPressed: () => Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (BuildContext context) => QRScanPage(),
//                  ),
//                ),
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(80.0)),
//                textColor: Colors.white,
//                padding: const EdgeInsets.all(0),
//                child: Container(
//                  alignment: Alignment.center,
//                  height: 50.0,
//                  width: size.width * 0.5,
//                  decoration: new BoxDecoration(
//                    borderRadius: BorderRadius.circular(80.0),
//                    color: Color(0XFFffc107),
//                  ),
//                  padding: const EdgeInsets.all(0),
//                  child: Text(
//                    "Entrar",
//                    textAlign: TextAlign.center,
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                ),
//
//
//*/
//
