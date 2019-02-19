import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'const.dart';
import 'home/back_dialog.dart';
import 'home/user_list_item.dart';
import 'home/bar.dart';

class MainScreen extends StatefulWidget {
  final String userId;

  MainScreen({@required this.userId}) : super();

  @override
  State createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  final String userId;
  bool _isLoading = false;

  MainScreenState({key: Key, this.userId});

  Future<bool> _onBackPress() async {
    switch (await openBackDialog(context)) {
      case 0:
        break;
      case 1:
        exit(0);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Container(
                child: StreamBuilder(
                    stream: Firestore.instance.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return buildUserItem(context, this.userId,
                                  snapshot.data.documents[index]);
                            });
                      }
                    }),
              ),
              Positioned(
                  child: _isLoading
                      ? Container(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                          color: Colors.white.withOpacity(0.8),
                        )
                      : Container())
            ],
          ),
          onWillPop: _onBackPress),
    );
  }
}
