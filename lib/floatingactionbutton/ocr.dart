import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ex1111/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '재료 추가하기',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 25,
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/fifth');
          },
        ),
      ),
      body: Column(
    children: <Widget>[
      SingleChildScrollView(
        child: Column(

          children: <Widget>[

                        OutlinedButton(
                            child: Text('빅스비로 글자인식하기'), onPressed: () async{
                          await launch('https://apps.samsung.com/appquery/appDetail.as?appId=com.samsung.android.visionintelligence&cId=000006055660');
                        }),
                     ],
                    ),
                  ),
                ],
              ),
    );
  }
}