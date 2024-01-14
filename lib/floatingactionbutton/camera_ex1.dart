import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {

  String parsedtext = '';

  @override
  Widget build(BuildContext context) {


    Future getFromGallery(ImageSource imageSource) async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 670, maxHeight: 970);
      if (pickedFile == null) return;

      var bytes = File(pickedFile.path.toString()).readAsBytesSync();
      String img64 = base64Encode(bytes);

      var url = 'https://api.ocr.space/parse/image';
      var payload = {
        "base64Image": "data:image/jpg;base64,${img64.toString()}",
        "language": "kor"};
    var header = {"apikey": 'K84085465688957'};

    var post = await http.post(Uri.parse(url), body: payload, headers: header);
    var result = jsonDecode(post.body);

    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText'];

    });

  }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        appBar: AppBar(

          title: Text('재료 추가하기',
            style: TextStyle(
                fontFamily: "ya", fontSize: 28, color: Colors.white),),
          centerTitle: true,
          elevation: 4.0,
          leading:

          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/sixth');
            },
          ),
        ),
        body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
       ElevatedButton(onPressed: () {
         getFromGallery(ImageSource.camera);
       }, child: Text('갤러리')),
          ElevatedButton(onPressed: () {
            getFromGallery(ImageSource.gallery);
          }, child: Text('갤러리')),

    ],
    ),
    ),
    );
  }

}

