import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/native_card/native_card.dart';
import 'package:native/model/update_user_req.dart';
import 'package:native/model/user.dart';
import 'package:native/model/user_prefs.dart';
import 'package:native/util/app_constants.dart';
import 'package:native/util/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isSuccess(int? statusCode) => statusCode != null && statusCode >= 200 && statusCode < 300;

List<User> _testUsers = [
  User(
    uid: '1',
    displayName: 'User1',
    photoURL: 'https://picsum.photos/id/237/200/300',
    email: 'test1@gmail.com',
    emailVerified: true,
    phoneNumber: '9898989898',
    phoneNumberVerified: true,
    customClaims: CustomClaims(gender: Gender.male, birthday: '12-12-2013', religion: 'Hindu', community: 'Brahmin', location: 'Pune', about: 'this is about me'),
  ),
  User(
    uid: '2',
    displayName: 'User2',
    photoURL: 'https://picsum.photos/id/2/200/300',
    email: 'test2@gmail.com',
    emailVerified: true,
    phoneNumber: '9898989899',
    phoneNumberVerified: true,
    customClaims: CustomClaims(gender: Gender.female, birthday: '12-12-2001', religion: 'Hindu', community: 'Marwadi', location: 'Mumbai', about: 'this is about me'),
  ),
];

@lazySingleton
class UserRepository {
  UserRepository(this._dioClient);
  final Dio _dioClient;

  Future<Either<AppException, User>> getCurrentUserDetails() async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await _dioClient.get(
        '/users/me',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) return Left(RequestError('Request error'));
      if (response.data == null) return Left(NoResponseBody());

      return Right(User.fromJson(response.data));
    } on DioException catch (e) {
      return Left(CustomException(e.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, NativeCard>> getCurrentUserNativeCardDetails() async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await _dioClient.get(
        '/users/me/nativeCard',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) return Left(RequestError('Request error'));
      if (response.data == null) return Left(NoResponseBody());

      return Right(NativeCard.fromJson(response.data['nativeCard']));
    } on DioException catch (e) {
      return Left(CustomException(e.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, User>> getUserDetails(String userId) async {
    var token = await _getStoreUserIdToken();
    if (token == null) {
      return Left(CustomException('Token not found'));
    }
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await _dioClient.get(
      '/users/$userId',
      options: Options(headers: headers),
    );

    if (!isSuccess(response.statusCode)) return Left(RequestError('Request error'));
    if (response.data == null) return Left(NoResponseBody());

    return Right(User.fromJson(response.data));
  }

  Future<Either<AppException, bool>> checkUser(String phoneNumber) async {
    try {
      var data = jsonEncode({
        "phoneNumber": phoneNumber
      });
      final response = await _dioClient.post('/public/checkUser', data: data);

      if (!isSuccess(response.statusCode)) {
        if (response.statusCode == 404) {
          return const Right(false);
        }
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      if (response.data['phoneNumberVerified'] ?? false) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on DioException catch (ex) {
      if (ex.response?.data['code'] == 'USER_NOT_FOUND') {
        return const Right(false);
      } else {
        return Left(ApiException(ex.response?.data['code']));
      }
    } catch (ex) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> updateUser(User user) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = jsonEncode(user.toJson());
      final response = await _dioClient.patch('/users/me', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return const Right(true);
    } on DioException catch (error) {
      return Left(CustomException(error.message));
    } catch (error) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> updateUserPrefs(UserPrefs userPrefs) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = jsonEncode(userPrefs.toJson());
      final response = await _dioClient.patch('/users/me/preference', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return const Right(true);
    } on DioException catch (error) {
      return Left(CustomException(error.message));
    } catch (error) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, String>> updateUserPhoto(String img64) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = jsonEncode({
        "photo": img64
      });
      final response = await _dioClient.post('/users/me/photo', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return Right(response.data['photoUrl']);
    } on DioException catch (error) {
      return Left(CustomException(error.message));
    } catch (error) {
      return Left(CustomException());
    }
  }

  Future<String?> _getStoreUserIdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userIdToken');
  }

}
