import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../const.dart';

Widget buildUserItem(BuildContext context, String userId, DocumentSnapshot document) {
  if (userId == document['id']) {
    return Container();
  } else {
    return Container(
      child: FlatButton(
        onPressed: () {
          print('Press!');
        },
        child: Row(
          children: <Widget>[
            Material(
              child: CachedNetworkImage(
                  placeholder: Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsets.all(15.0),
                  ),
                  imageUrl: document['photoUrl'],
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              clipBehavior: Clip.hardEdge,
            ),
            Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'NickName: ${document['nickname']}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(2.0),
                      ),
                      Container(
                        child: Text(
                          'About Me: ${document['aboutMe'] ?? 'Who am I?'}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(2.0),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
    );
  }
}