import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:native/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class RefreshTokenManager {
  final FirebaseAuth _auth;
  final Config _config;

  RefreshTokenManager(this._auth, this._config);

  Future<String?> refreshToken() async {
    // TODO: Consider to inject SharedPreferences rather get here
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int currentTimestamp = Timestamp.now().seconds;
    int? timestamp = prefs.getInt('userTokenTimestampInSeconds') ?? 0;
    if ((currentTimestamp - timestamp) <=
        _config.refreshTokenDurationInSeconds) {
      String? token = await _auth.currentUser?.getIdToken(true);
      if (token != null) {
        await prefs.setString('userIdToken', token);
      }
      return token;
    }
    return null;
  }
}
