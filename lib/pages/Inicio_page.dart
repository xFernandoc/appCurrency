import 'dart:convert';
import 'dart:io';

import 'package:app_vane/pages/deposito_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:page_transition/page_transition.dart';

class Inicio extends StatefulWidget {
  @override
  _Inicio createState() => new _Inicio();
}

class _Inicio extends State<Inicio> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _cambio = 0;
  double _sueldo = 0;
  final _mes = TextEditingController();
  final _dias = TextEditingController();
  final _soles = TextEditingController();
  final _euros = TextEditingController();
  _mio() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
          child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black45)],
        ),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.power_settings_new),
                  color: Colors.grey.shade800,
                  onPressed: () {},
                ),
              ),
              Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange]),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/cerdo.png",
                      fit: BoxFit.cover,
                      height: 50,
                    ),
                    //backgroundImage: AssetImage("assets/cerdo.png" ),
                    radius: 40,
                  )),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Vanessa nohely",
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )),
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _validarcambio();
  }

  _validarcambio() async {
    var response = await http.get(
        "https://free.currconv.com/api/v7/convert?q=EUR_PEN&compact=ultra&apiKey=98e008400b95d223d1de");
    var decodeJson = jsonDecode(response.body);
    setState(() {
      _cambio = decodeJson["EUR_PEN"]-0.2;
    });
  }

  var maskFormatter = new MaskTextInputFormatter(mask: '\u{20AC}######');
  var maskFormatter2 = new MaskTextInputFormatter(mask: 'S/. #########');

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (_)=>
          AssetGiffyDialog(
            image: Image.asset("assets/exit.gif"),
            title: Text("SALIR"),
            onOkButtonPressed: (){
              exit(0);
            },
          )
        );
      },
      child: Scaffold(
          drawer: _mio(),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
               Navigator.push(context, PageTransition(child: Deposito(), type: PageTransitionType.fade));
            },
            child: Icon(Icons.add,color : Colors.green.shade700, size: 40,),
            backgroundColor: Colors.white,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar:BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.orange.shade500,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal : 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.face, color : Colors.white, size: 35,), onPressed: (){}),
                  IconButton(icon: Icon(Icons.menu, color : Colors.white, size: 35,), onPressed: (){}),
                  SizedBox(width: ancho*0.01,),
                  IconButton(icon: Icon(Icons.menu, color : Colors.white, size: 35,), onPressed: (){}),
                  IconButton(icon: Icon(Icons.menu, color : Colors.white, size: 35,), onPressed: (){}),
                ],
              ),
            ),
          ),
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: Container(
            width: ancho,
            height: alto,
            child: Column(
              children: <Widget>[
                Container(
                  height: alto*0.08,
                  width: ancho,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey)]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.orange.shade500,
                              size: 30,
                            ),
                            onPressed: () =>
                                _scaffoldKey.currentState.openDrawer()),
                        flex: 1,
                      ),
                      Expanded(
                          flex: 15,
                          child: Center(
                              child: Text(
                            "HERRAMIENTAS",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade500,
                                fontSize: 30),
                          )))
                    ],
                  ),
                ),
                SizedBox(
                  height: alto * 0.02,
                ),
                Container(
                  width: ancho,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.orange.shade500, width: 3)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: _cambio != 0
                            ? Text(
                                "1 \u{20AC}  =  S/. ${_cambio.toStringAsFixed(2)} ",
                                style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              )
                            : CircularProgressIndicator(),
                      ),
                      Divider(
                        height: alto * 0.02,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          width: ancho - 20,
                          height: 145,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                color: Colors.orange.shade500,
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("Cálculo de sueldo",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Icon(
                                                FontAwesomeIcons.calculator,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Mes : ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.brown)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: 70,
                                      height: 20,
                                      child: new TextField(
                                        textAlign: TextAlign.center,
                                        controller: _mes,
                                        style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [maskFormatter],
                                      )),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text("Dias : ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.brown)),
                                  Container(
                                      width: 70,
                                      height: 20,
                                      child: new TextField(
                                        controller: _dias,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        keyboardType: TextInputType.number,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.arrowAltCircleRight,
                                      color: Colors.orange.shade900,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _sueldo = (double.parse(_mes.text
                                                    .substring(
                                                        1, _mes.text.length)) *
                                                int.parse(_dias.text)) /
                                            30;
                                      });
                                    },
                                    splashColor: Colors.orange.shade500,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _sueldo > 0
                                  ? RichText(
                                      text: TextSpan(
                                          style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Tu sueldo sera de :"),
                                            TextSpan(
                                                text:
                                                    " \u{20AC}. ${_sueldo.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w800))
                                          ]),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                          elevation: 5,
                          child: Container(
                            width: ancho - 20,
                            height: 115,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  color: Colors.orange.shade500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Depósito",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Icon(
                                                  FontAwesomeIcons.coins,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal : 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: <Widget>[
                                              Text("Soles : ",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w800,
                                                      color: Colors.brown)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  width: ancho*0.25,
                                                  height: 20,
                                                  child: new TextField(
                                                    onChanged: (valor){
                                                      setState(() {
                                                        _euros.text="";
                                                        if (valor=="") {
                                                        _euros.text = "";
                                                        }else{
                                                          double prv = double.parse(valor.substring(3,valor.length)) / double.parse(_cambio.toStringAsFixed(2));
                                                          _euros.text = "\u{20AC}${prv.toStringAsFixed(2)}";
                                                        }
                                                      });
                                                    },
                                                    textAlign: TextAlign.center,
                                                    controller: _soles,
                                                    style: GoogleFonts.ubuntu(
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                        inputFormatters: [
                                                    maskFormatter2
                                                  ],
                                                  )),
                                            ],
                                          )),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text("Euros : ",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.brown)),
                                            Container(
                                                width: ancho*0.25,
                                                height: 20,
                                                child: new TextField(
                                                  onChanged: (valor){
                                                    setState(() {
                                                      _soles.text="";
                                                      if (valor=="") {
                                                        _soles.text = "";
                                                      }else{
                                                        double prv = double.parse(valor.substring(1,valor.length)) * double.parse(_cambio.toStringAsFixed(2));
                                                        _soles.text = "S/. ${prv.toStringAsFixed(2)}";
                                                      }
                                                    });
                                                  },
                                                  controller: _euros,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.ubuntu(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    maskFormatter
                                                  ],
                                                )),
                                          ],
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
