import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/user.dart';
import 'package:native/util/exceptions.dart';

bool isSuccess(int? statusCode) => statusCode != null && statusCode >= 200 && statusCode < 300;

List<User> _testUsers = [
  User(
    id: '1',
    displayName: 'User1',
    photoURL: 'https://picsum.photos/id/237/200/300',
    email: 'test1@gmail.com',
    emailVerified: true,
    phoneNumber: '9898989898',
    phoneNumberVerified: true,
    customClaims: CustomClaims(gender: 'male', birthday: '12-12-2013', religion: 'Hindu', community: 'Brahmin', location: 'Pune', about: 'this is about me'),
  ),
  User(
    id: '2',
    displayName: 'User2',
    photoURL: 'https://picsum.photos/id/2/200/300',
    email: 'test2@gmail.com',
    emailVerified: true,
    phoneNumber: '9898989899',
    phoneNumberVerified: true,
    customClaims: CustomClaims(gender: 'female', birthday: '12-12-2001', religion: 'Hindu', community: 'Marwadi', location: 'Mumbai', about: 'this is about me'),
  ),
];

@lazySingleton
class UserRepository {
  UserRepository(this._dioClient);
  final Dio _dioClient;

  Future<Either<Exception, User>> getUserDetails(String userId) async {
    // final response = await _dioClient.get('/users/$userId');

    // if (!isSuccess(response.statusCode)) return Left(RequestError());
    // if (response.data == null) return Left(NoResponseBody());

    // final body = response.data as List;
    // return Right(body.map((e) => e as int).toList());
    return Future.delayed(const Duration(seconds: 2), () {
      var user = _testUsers.cast<User?>().firstWhere(
            (element) => element?.id == userId,
            orElse: () => null,
          );
      return user != null ? Right(user) : Left(RequestError());
    });
  }
}
