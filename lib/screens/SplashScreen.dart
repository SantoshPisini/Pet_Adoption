import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption/RoutingConstants.dart';
import 'package:pet_adoption/widgets/PawWidget.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 2500),
    );
    _animation = Tween(begin: 0.0, end: 100.0).animate(_controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          Navigator.pushReplacementNamed(context, LoginViewRoute);
        } else if (state == AnimationStatus.dismissed) {
          //print("dismissed");
        }
      })
      ..addListener(() {
        //print("value:${_animation.value}");
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              _pawWidget(_animation.value),
              _textWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pawWidget(double animationValue) {
    List<double> arr = [0.0, 0.0, 0.0];
    if (animationValue < 26) {
      arr = [1.0, 0.0, 0.0];
    } else if (25 < animationValue && animationValue < 75) {
      arr = [0.0, 1.0, 0.0];
    } else {
      arr = [0.0, 0.0, 1.0];
    }
    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            child: PawWidget(
              size: 250,
              angle: 64,
              opacity: arr[2],
            ),
            tag: 'paw',
          ),
          PawWidget(
            size: 150,
            angle: -16,
            opacity: arr[1],
          ),
          PawWidget(
            size: 100,
            angle: 56,
            opacity: arr[0],
          ),
        ],
      ),
    );
  }

  Widget _textWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Pet Adoption',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          Text(
            'India',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
