import 'package:app_vane/pages/Inicio_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_animations/simple_animations.dart';
class PigAnimation extends StatelessWidget {
  final int delay;
  final double ancho;
  final double alto;
  PigAnimation({this.delay,this.ancho,this.alto});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("caminar").add(Duration(milliseconds: delay), Tween(begin: 0.0, end: alto-ancho*0.3), curve: Curves.easeInOut),
      Track("tam").add(Duration(milliseconds: delay), Tween(begin: 1.0, end: 1.1))
    ]);

    return ControlledAnimation(
      delay: tween.duration,
      duration: tween.duration,
      tween: tween,
      child: Image.asset("assets/cerdo.png",width: ancho*0.3,),
      builderWithChild: (context, child, animation) => Transform.translate(
        offset: Offset((ancho/2)-ancho*0.15,animation["caminar"]),
        child: ControlledAnimation(
          delay: tween.duration,
          duration: tween.duration,
          tween: tween,
          playback: Playback.MIRROR,
          child: Image.asset("assets/cerdo.png",width: ancho*0.3,),
          builderWithChild: (context,child,anim)=>Transform.scale(
            scale: anim["tam"],
            child: GestureDetector(child: child,
            onTap: (){
              Navigator.push(context, PageTransition(child: Inicio(), type: PageTransitionType.fade));
            },),
          ),
        ),
      )
    );
  }
}