import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = 'number';
  static const ID = 'id';
  static const NAME = 'displayName';

  String _number;
  String _id;

  String get number => _number;
  String get id => _id;
  String get name => name;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _number = snapshot.get('NUMBER');
    _id = snapshot.get('ID');
  }
}
