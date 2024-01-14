import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex1111/floatingactionbutton/ocr.dart';
import 'package:ex1111/landingpage.dart';
import 'package:ex1111/shoppingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/intl.dart';
import 'package:ex1111/floatingactionbutton/make.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:home_widget/home_widget.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HomeWidget.registerBackgroundCallback(backgroundCallback);


  runApp(MyApp());
}

Future<void> backgroundCallback(Uri? uri) async {

}


class List {
  //재료명 컨트롤러에 대한 파이어베이스 연동한 클래스인데 여기서 유통기한 컨트롤러에 대한 파이어베이스를 연동하려니 어떻게 넣어야할지 오류가 나요
  bool isDone;
  String title;

  List(this.title, {this.isDone = false});
}


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/001.gif',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
        } else {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: '냉장고를 부탁해',
              theme: ThemeData(primarySwatch: Colors.teal),
              home: Ascreen(title: ''),
              routes: {
                /* '/first': (context) => LandingPage(), */
               /* '/second': (context) => DdayScreen(), */
                '/third': (context) => ShoppingScreen(),
                /*  '/fourth': (context) => HomePage(title: ''), */
                '/fifth': (context) => Ascreen(title: ''),
                '/sixth': (context) => Home(),
              });
        }
      },
    );
  }
}

class Ascreen extends StatefulWidget {
  const Ascreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _Ascreen createState() => _Ascreen();
}

class _Ascreen extends State<Ascreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  var _listController = TextEditingController();


  /* Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('재료를 입력해 주세요'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _ymdController,
              decoration: InputDecoration(hintText: "재료명"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(primary:Colors.red),
                child: Text('CANCEL',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(primary:Colors.green),
                child: Text('OK',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  late String codeDialog;
  late String valueText;
*/


  @override
  void _addList(List list) {
    FirebaseFirestore.instance
        .collection('list')
        .add({'title': list.title, 'isDone': list.isDone});

    _listController.text = '';

  }


  @override
  void _deleteList(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('list').doc(doc.id).delete();
  }


  @override
  void _toggleList(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('list').doc(doc.id).update({
      'isDone': !doc['isDone'],
    });
  }


  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

        title: Text(
          '냉장고를 부탁해',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 25,
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading:
        IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              accountName: Text('냉장고를 부탁해',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              accountEmail: Text('냉장고안 식재료를 확인해보세요!',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/33.jpg'),
                backgroundColor: Colors.white,
              ),

            ),

            ListTile(
              leading: Icon(
                Icons.home_outlined,
              ),
              title: const Text(
                '메인화면으로 돌아가기', style: TextStyle(fontSize: 15.0),),
              onTap: () {
                Navigator.pushNamed(context, '/fifth');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_shopping_cart,
              ),
              title: const Text(
                  '장보기 리스트 작성하기', style: TextStyle(fontSize: 15.0)),
              onTap: () {
                Navigator.pushNamed(context, '/third');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add,
              ),
              title: const Text(
                  '영수증 글자 인식하기', style: TextStyle(fontSize: 15.0)),
              onTap: () async {
                await launch(
                    'https://apps.samsung.com/appquery/appDetail.as?appId=com.samsung.android.visionintelligence&cId=000006055660');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_active_outlined,
              ),
              title: const Text('눌러서 푸시알림신청', style: TextStyle(fontSize: 15.0)),
              onTap: () {
                Navigator.pushNamed(context, '/sixth');
              },
            ),
            AboutListTile(
              icon: Icon(
                  Icons.info_outline
              ),
              child: Text('앱 정보', style: TextStyle(fontSize: 15.0)),
              applicationIcon:
              Icon(Icons.info_outline),
              applicationName: '냉장고를 부탁해',
              applicationVersion: '1.0.1',
              applicationLegalese: '@ 2022 kmou 딤채',

            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),

        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5.0)),
                Expanded(
                  child: TextField(
                    controller: _listController,
                    style: TextStyle(fontSize: 17.0),
                    decoration: InputDecoration(
                      labelText: '재료명(yymmdd)',
                      labelStyle: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: 10.0)),

                ElevatedButton(
                    onPressed: () => {_addList(List(_listController.text))},
                    child: Text('추가', style: TextStyle(fontSize: 17))),

              ],
            ),

            StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection('list').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final documents = snapshot.data?.docs;

                  return Expanded(
                    child: ListView(
                      children:

                      documents!.map((doc) => _buildItemWidget(doc)).toList(),

                    ),
                  );
                }),


          ],
        ),


      ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final list = List(doc['title'], isDone: doc['isDone']);


    return ListTile(
      onTap: () => _toggleList(doc),
      title: Text(
        list.title,
        style: list.isDone
            ? TextStyle(
          decoration: TextDecoration.lineThrough,
          decorationThickness: 3,
          fontStyle: FontStyle.italic,
        )
            : null,
      ),


      trailing:
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => _deleteList(doc),
    ),


    );


  }

}
