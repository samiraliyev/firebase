import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String id;
  final String name;
  final String surname;
  final String avatar;
  final String mail;
//named parameters construction
  Users({this.id, this.name, this.surname, this.avatar, this.mail});

// for user create from document which database-document
  factory Users.madeFromDocument(DocumentSnapshot doc) {
    return Users(
      id: doc.documentID,
      name: doc.data["name"],
      surname: doc.data["surname"],
      mail: doc.data["mail"],
      avatar: doc.data["avatar"],
    );
  }

  factory Users.madeFromFirebase(FirebaseUser user) {
    return Users(
      id: user.uid,
      name: user.displayName,
      mail: user.email,
      avatar: user.photoUrl,
    );
  }
}
