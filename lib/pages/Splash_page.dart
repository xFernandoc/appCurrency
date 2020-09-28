import 'package:app_vane/anims/FadeAnimation.dart';
import 'package:app_vane/anims/piganimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        AnimacionOpacity(
          child: Center(
            child: Text(
              "HERRAMIENTAS",
              style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          delay: 1000,
        ), 
        PigAnimation(
            delay: 1000,
            alto: alto,
            ancho: ancho,
          ),
      ],
    ));
  }
}
