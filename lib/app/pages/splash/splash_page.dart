import 'package:corona_data/app/pages/splash/splash_controller.dart';
import 'package:corona_data/app/shared/widgets/animations/virus_infection_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Center(
          child: VirusInfectionCircularAnimation(
        animation: VirusInfectionAnimation.default_animation,
        fit: BoxFit.contain,
        size: 400,
      )),
    );
  }
}
