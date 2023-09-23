import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseRepository {
  FirebaseRepository(this._auth);
  final FirebaseAuth _auth;
}
