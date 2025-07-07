import 'dart:async';
import 'dart:math' as math;

import 'package:covid_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{//tickerproviderstaemixin is used for animation

  //make controller to control animation
  late final AnimationController _controller=AnimationController(
      duration : const Duration(seconds: 3),//3 seconds to animate bcz splash screen is 3 seconds build

      vsync: this)..repeat();



  @override

//   dispose this animated splash screen when shift to another screen ///i-e: remove
  void dispose() {
    // TODO: implement dispose
    super.dispose();
_controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();

    //hold splash screen for 5 seconds then goto world stats screen
    Timer(const Duration(seconds: 5),() => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorldStatsScreen()))
    );


  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            //i want my virus logo to spin so use animated builder
            AnimatedBuilder(
                animation: _controller,//_controller control animation
                //pass conext to build context then pass child to widget which has to build

                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage("images/virus.png")),
                  ),
                ),
                builder: (BuildContext context , Widget? child)//  ? means may be non null or null without ? it always get non null
                {
                  return Transform.rotate(

                    //_controller.value * 2.0 gives you a number between 0.0 and 2.0.
                    //
                    // Then … * math.pi transforms that into a range from 0.0 up to 2π radians (≈6.28318). to rotate angle
                    angle:_controller.value*2.0*math.pi,
                    child:child, //Inserts the pre-built container/image from step 2 into the rotating transform
                  );


                }),
            SizedBox(height:  MediaQuery.of(context).size.height *0.08,),//get 8 percent of screen height

            //text to shown below image virus
            const Align(
              alignment: Alignment.center,
              child: Text('CoviD-19 \n Tracker App' ,textAlign: TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 28,color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
