import 'dart:async';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex1111/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:flutter/src/widgets/framework.dart';


class Shopping {
  bool isDone;
  String title;

  Shopping(this.title, {this.isDone = false});
}

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {


  var _shoppingController = TextEditingController();

  @override
  void _addShopping(Shopping shopping) {
    FirebaseFirestore.instance.collection('shoppinglist').add({'title':shopping.title, 'isDone':shopping.isDone});
    _shoppingController.text = '';
  }



  void _deleteShopping(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('shoppinglist').doc(doc.id).delete();
  }

  void _toggleShopping(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('shoppinglist').doc(doc.id).update({
      'isDone': !doc['isDone'],
    });
  }

  void dispose() {
    _shoppingController.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '장보기 리스트',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 25,
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _shoppingController,



                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _addShopping(Shopping(_shoppingController.text)),
                    child: Text('추가', style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),


              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('shoppinglist').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final documents = snapshot.data?.docs;
                  return Expanded(
                        child: ListView(
                          children: documents!.map((doc) => _buildItemWidget(doc)).toList(),
                        ),

                      );
                },
              ),

    ],
    ),
    ),
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
final shopping = Shopping(doc['title'], isDone: doc['isDone']);
    return ListTile(
      onTap: () => _toggleShopping(doc),
      title: Text(
        shopping.title,
        style: shopping.isDone
            ? TextStyle(
                decoration: TextDecoration.lineThrough,decorationThickness: 4,
                fontStyle: FontStyle.italic,
              )
            : null,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteShopping(doc),
      ),
    );
  }
}
