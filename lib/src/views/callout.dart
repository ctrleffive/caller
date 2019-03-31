import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CallOut extends StatefulWidget {
  @override
  _CallOutState createState() => _CallOutState();
}

class _CallOutState extends State<CallOut> with SingleTickerProviderStateMixin {
  AnimationController _bgAnimationController;

  @override
  void initState() {
    this._bgAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      upperBound: 1.5,
      lowerBound: 1,
    );
    this._bgAnimationController.reverse(from: 1.5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int height = MediaQuery.of(context).size.height.round();
    return ScaleTransition(
      scale: this._bgAnimationController,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 1],
              ),
            ),
          ),
          Image(
            image: CachedNetworkImageProvider('http://i.pravatar.cc/$height?caller'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: Colors.black26),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.call, size: 20, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Outgoing Call', style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      SizedBox(height: 45),
                      Text(
                        'Drake Williams',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Technopark',
                        style: TextStyle(
                          color: Colors.white30,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.call,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
