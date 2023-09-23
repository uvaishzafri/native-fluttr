import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:native/repo/model/story.dart';
import 'package:native/util/exceptions.dart';
import 'package:injectable/injectable.dart';

bool isSuccess(int? statusCode) =>
    statusCode != null && statusCode >= 200 && statusCode < 300;

@lazySingleton
class HackNewsRepository {
  HackNewsRepository(this._dioClient);
  final Dio _dioClient;

  Future<Either<Exception, List<int>>> topStories() async {
    final response = await _dioClient.get('/topstories.json');

    if (!isSuccess(response.statusCode)) return Left(RequestError());
    if (response.data == null) return Left(NoResponseBody());

    final body = response.data as List;
    return Right(body.map((e) => e as int).toList());
  }

  Future<Either<Exception, List<int>>> bestStories() async {
    final response = await _dioClient.get('/beststories.json');

    if (!isSuccess(response.statusCode)) return Left(RequestError());
    if (response.data == null) return Left(NoResponseBody());

    final body = response.data as List;
    return Right(body.map((e) => e as int).toList());
  }

  Future<Either<Exception, Story>> story(int id) async {
    final response = await _dioClient.get('/item/$id.json');

    if (!isSuccess(response.statusCode)) return Left(RequestError());
    if (response.data == null) return Left(NoResponseBody());

    final story = Story.fromJson(response.data as Map<String, dynamic>);
    return Right(story);
  }
}
