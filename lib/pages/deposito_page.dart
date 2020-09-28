import 'package:flutter/material.dart';

class Deposito extends StatefulWidget {
  @override
  _Deposito createState() => new _Deposito();
}
class _Deposito extends State<Deposito> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(),
      child: Scaffold(

      ),
    );
  }
  
}