import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

const String userCollection = 'users';

Future<User> userDaoGetUser(String id) async {
  final QuerySnapshot result = await Firestore.instance
      .collection(userCollection)
      .where('id', isEqualTo: id)
      .getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  if (documents.length == 0) {
    return null;
  } else {
    return User(
        id: documents[0]['id'],
        nickname: documents[0]['nickname'],
        photoUrl: documents[0]['photoUrl'],
        aboutMe: documents[0]['aboutMe']);
  }
}

void userDaoAddUser(User user) {
  Firestore.instance
    ..collection(userCollection).document(user.id).setData({
      'id': user.id,
      'nickname': user.nickname,
      'photoUrl': user.photoUrl,
    });
}

Stream getUsersSnapshot(){
  return Firestore.instance.collection('users').snapshots();
}


