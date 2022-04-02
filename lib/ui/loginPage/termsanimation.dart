import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:flutter/material.dart';

class TermsAnimation extends StatelessWidget {
  const TermsAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: TranslationAnimatedWidget.tween(

          translationDisabled: Offset(0,200),
         // delay: Duration(milliseconds: 1000),
          duration: Duration(milliseconds: 1100),
          translationEnabled: Offset(0,0),
          //enabled: _dispaly,
          child: OpacityAnimatedWidget.tween(
              opacityDisabled: 0,
              opacityEnabled: 1,
              duration: Duration(milliseconds: 500),
              child: Image.asset("assets/terms_logo_red.png",scale: 5,))),
    );
  }
}
