import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CallIn extends StatefulWidget {
  @override
  _CallInState createState() => _CallInState();
}

class _CallInState extends State<CallIn> with SingleTickerProviderStateMixin {
  final StreamController<double> _blurStream = StreamController<double>.broadcast();
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
  void dispose() {
    _blurStream.close();
    super.dispose();
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
          StreamBuilder<double>(
            initialData: 0,
            stream: this._blurStream.stream,
            builder: (_, AsyncSnapshot<double> blurSnap) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSnap.data, sigmaY: blurSnap.data),
                child: Container(color: Colors.black26),
              );
            }
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
                            Text('Incoming Call', style: TextStyle(color: Colors.white))
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
                        'is trying to call you',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () async {
                                Timer.periodic(Duration(milliseconds: 10), (Timer time) {
                                  if (time.tick >= 100) {
                                    time.cancel();
                                    Future.delayed(Duration(seconds: 5), () => Navigator.pop(context));
                                  }
                                  this._blurStream.sink.add(double.parse(time.tick.toString()));
                                });
                              },
                              child: Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tap to Accept',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
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
