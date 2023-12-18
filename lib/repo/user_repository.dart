import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:native/config.dart';
import 'package:native/feature/fav_card/models/fav_card_data.dart';
import 'package:native/feature/fav_card/models/item_detail_model.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/models/fav_card_tutorial_model.dart';
import 'package:native/manager/refresh_token_manager.dart';
import 'package:native/model/app_notification.dart';
import 'package:native/model/likes_model.dart';
import 'package:native/model/native_card/native_card.dart';
import 'package:native/model/user.dart';
import 'package:native/model/user_prefs.dart';
import 'package:native/util/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../feature/fav_card/models/fav_card_items/fav_card_items.dart';

bool isSuccess(int? statusCode) => statusCode != null && statusCode >= 200 && statusCode < 400;

@lazySingleton
class UserRepository {
  UserRepository(this._dioClient, this._config, this._refreshTokenManager);

  final Dio _dioClient;
  final Config _config;
  final RefreshTokenManager _refreshTokenManager;

  Future<Either<AppException, User>> getCurrentUserDetails() async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/users/me',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      return Right(User.fromJson(response.data));
    } on DioException catch (err) {
      if (err.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(err.message));
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
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/users/me/nativeCard',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      return Right(NativeCard.fromJson(response.data['nativeCard']));
    } on DioException catch (err) {
      if (err.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(err.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, NativeCard>> getUserNativeCardDetails({required String userId}) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/users/$userId/nativeCard',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      return Right(NativeCard.fromJson(response.data['nativeCard']));
    } on DioException catch (err) {
      if (err.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(err.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, User>> getUserDetails(String userId) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/users/$userId',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      return Right(User.fromJson(response.data));
    } on DioException catch (err) {
      if (err.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(err.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> checkEmailRefId(String refId) async {
    try {
      final response = await _dioClient.get('/public/verify?refId=$refId',
          options: Options(
            followRedirects: false,
            validateStatus: (status) => status != null && status < 400,
          ));

      if (!isSuccess(response.statusCode)) {
        if (response.statusCode == 404) {
          return const Right(false);
        }
        return Left(RequestError(response.statusMessage ?? ''));
      }
      final location = response.headers['Location'];
      if (location == null || location.isEmpty) return Left(NoResponseBody());
      final uri = Uri.parse(location[0]);
      if (uri.hasQuery == false) return Left(NoResponseBody());
      String? uid = uri.queryParameters['uid'];
      if (uid == null) return Left(NoResponseBody());

      return await checkUserEmailVerified(uid);
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

  Future<Either<AppException, bool>> checkUserEmailVerified(String uid) async {
    try {
      var data = jsonEncode({"uid": uid});
      final response = await _dioClient.post('/public/checkUser', data: data);

      if (!isSuccess(response.statusCode)) {
        if (response.statusCode == 404) {
          return const Right(false);
        }
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      if (response.data['emailVerified'] ?? false) {
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

  Future<Either<AppException, bool>> checkUser(String phoneNumber) async {
    try {
      var data = jsonEncode({"phoneNumber": phoneNumber});
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

  Future<Either<AppException, User>> updateUser(User user) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var data = jsonEncode(user.toJson());
      final response = await _dioClient.patch('/users/me', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return Right(User.fromJson(response.data));
      // return const Right(true);
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
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
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var data = jsonEncode(userPrefs.toJson());
      final response = await _dioClient.patch('/users/me/preference', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return const Right(true);
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
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
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var data = jsonEncode({"photo": img64});
      final response = await _dioClient.post('/users/me/photo', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return Right(response.data['photoUrl']);
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(error.message));
    } catch (error) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> verifyEmail(String email, String uid) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var data = jsonEncode({
        'email': email,
        'actionCodeSettings': {
          'url': "${_config.verifyEmailRedirectUrl}?uid=$uid",
          'handleCodeInApp': false,
          'androidInstallApp': true,
          'androidPackageName': 'me.benative.mobile',
          'iOSBundleId': 'me.benative.mobile',
        }
      });
      final response = await _dioClient.post('/users/me/verify/email', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }

      return const Right(true);
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(error.message));
    } catch (error) {
      return Left(CustomException());
    }
  }

  Future<String?> _getStoreUserIdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _refreshTokenManager.refreshToken();
    return prefs.getString('userIdToken');
  }

  Future<Either<AppException, List<AppNotification>>> getCurrentUserNotifications() async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/users/me/notifications?size=10',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      List<AppNotification> appNotificationList = [];
      for (var notification in response.data) {
        var appNotification = AppNotification.fromJson(notification);
        if (appNotification.fromUser != null) {
          // no-op
        } else if (appNotification.fromUid != null) {
          var user = await getUserDetails(appNotification.fromUid!);
          if (user.isRight) {
            appNotification = appNotification.copyWith(fromUser: user.right);
          }
        }
        appNotificationList.add(appNotification);
      }
      return Right(appNotificationList);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(e.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, LikesModel>> getLikesReport() async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/users/me/likes?size=10',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      return Right(LikesModel.fromJson(response.data));
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(error.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> reportUser(String userId, String reasonCategory, String? reasonDesc) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      dynamic data;
      if (reasonDesc?.isNotEmpty ?? false) {
        data = jsonEncode({
          'reason': {"category": reasonCategory, "description": reasonDesc}
        });
      } else {
        data = jsonEncode({
          'reason': {"category": reasonCategory}
        });
      }
      final response = await _dioClient.post('/chats/users/$userId/issue', data: data, options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return const Right(true);
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(error.message));
    } catch (error) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, List<User>>> getRecommendations() async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/matches/recommendation',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      return Right((response.data as List).map((e) => User.fromJson(e)).toList());
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(error.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, bool>> requestMatch(String userId) async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.post('/matches/users/$userId/request', options: Options(headers: headers));

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError(response.statusMessage ?? ''));
      }
      if (response.data == null) return Left(NoResponseBody());
      return const Right(true);
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(error.message));
    } catch (error) {
      return Left(CustomException());
    }
  }

  Future<Either<AppException, List<User>>> getMatches() async {
    try {
      var token = await _getStoreUserIdToken();
      if (token == null) {
        return Left(CustomException('Token not found'));
      }
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      final response = await _dioClient.get(
        '/matches',
        options: Options(headers: headers),
      );

      if (!isSuccess(response.statusCode)) {
        return Left(RequestError('Request error'));
      }
      if (response.data == null) return Left(NoResponseBody());

      return Right((response.data as List).map((e) => User.fromJson(e)).toList());
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        return Left(UnauthorizedException());
      }
      return Left(CustomException(error.message));
    } catch (e) {
      return Left(CustomException());
    }
  }

  //TODO: Implement this
  Future<Either<AppException, FavCardDataModel>> getFavCardData() async {
    return Future.delayed(const Duration(seconds: 0), () => Right(favCardDataModel));
  }

  //TODO: Implement this
  Future<Either<AppException, ItemDetailModel>> getItemDetail({required String id}) {
    return Future.delayed(const Duration(seconds: 0), () => Right(itemDetail));
  }

  //TODO: Implement this
  Future<Either<AppException, bool>> unLikeFavCard({required String id}) {
    return Future.delayed(const Duration(seconds: 0), () => Right(true));
  }

  //TODO: Implement this
  Future<Either<AppException, bool>> likeFavCard({required String id, required String comment}) {
    return Future.delayed(const Duration(seconds: 0), () => Right(true));
  }

  //TODO: Implement this
  Future<Either<AppException, List<FavCardItemModel>>> getFavCardSearchResults({required String query}) {
    return Future.delayed(const Duration(seconds: 0), () => Right(dummyFavCardItems));
  }

  //TODO: Implement this
  Future<Either<AppException, List<FavCardItemModel>>> getTopFavCards() async {
    return Future.delayed(const Duration(seconds: 0), () => Right(dummyFavCardItems));
  }

  //TODO: Implement this
  Future<Either<AppException, bool>> updateTopFavCards({required List<FavCardItemModel> favCards}) {
    return Future.delayed(const Duration(seconds: 0), () => Right(true));
  }

  //TODO: Implement this
  Future<Either<AppException, FavCardTutorialModel>> getFavCardTutorialData() {
    return Future.delayed(const Duration(seconds: 0), () => Right(tutorialModel));
  }

  //TODO: Implement this
  Future<void> markTutorialCompletion() async {}
}
