import 'package:flutter/material.dart';
import 'package:flutter_ecomrce_test/componints/components.dart';
import 'package:flutter_ecomrce_test/modeuls/bottom_screen/Bottom_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Future.delayed(Duration(seconds: 3),(){
      navgiToAndFinsh(context, BottomScreen());
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Center(
            child: Image.asset("assets/splash.png"),
          )),
          Text("data")
        ],
      ),
    );
  }
}
