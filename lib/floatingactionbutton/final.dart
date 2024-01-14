import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PickedFile? _image;

  getImageFromCam() async {
    var image =
    await ImagePicker.platform.pickImage(source: ImageSource.camera);
    _image = image;
    print(_image!.path);
  }

  getImageFromGallery() async {
    var image =
    await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    _image = image;
    print(_image!.path);
  }

  String parsedtext = '';

  parsethetext() async {
    final image = await ImagePicker().getImage(
        source: ImageSource.gallery, maxWidth: 670, maxHeight: 970);
    final image1 = await ImagePicker().getImage(
        source: ImageSource.camera, maxWidth: 670, maxHeight: 970);
    if (image == null) return;
    if (image1 == null) return;

    var bytes = File(image.path.toString()).readAsBytesSync();
    var bytes1 = File(image1.path.toString()).readAsBytesSync();
    String img64 = base64Encode(bytes);
    String img641 = base64Encode(bytes1);
    var url = 'https://api.ocr.space/parse/image';
    var payload = {
      "base64Image": "data:image/jpg;base64,${img64.toString()}",
      "language": "kor"
    };
    var payload1 = {
      "base64Image": "data:image/jpg;base64,${img641.toString()}",
      "language": "kor"
    };
    var header = {"apikey": "K84085465688957"};
    var post = await http.post(Uri.parse(url), body: payload, headers: header);
    var post1 = await http.post(
        Uri.parse(url), body: payload1, headers: header);
    var result = jsonDecode(post.body);
    var result1 = jsonDecode(post1.body);

    setState(() {
      parsedtext = result['ParsedResults'][0]['ParsedText'];
      parsedtext = result1['ParsedResults'][0]['ParsedText'];
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(context, '/fifth');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text("인식한 글자 : "),
                  SizedBox(height: 10.0),
                  Text(parsedtext),
                ],
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => parsethetext(),
                    child: Icon(Icons.camera_alt_outlined),
                     ),
                  ElevatedButton(
                      onPressed: () => parsethetext(),
                    child: Icon(Icons.),),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}