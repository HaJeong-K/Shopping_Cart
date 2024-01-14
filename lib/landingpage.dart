import 'package:ex1111/main.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {


  @override
  _LandingPageState createState() => _LandingPageState();

}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),(){
      Get.offAll(() => Ascreen(title: ''));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.indigoAccent,
              child: Center(
                child: Text('냉장고 목록을 불러오는중 입니다',
                    style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 27,color: Colors.limeAccent)),

              ),
            ),
            CircularProgressIndicator()
          ],
        )
    );
  }
}

