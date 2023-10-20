import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

@lazySingleton
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._userRepository) : super(const EditProfileState.initial());

  final UserRepository _userRepository;

  // getProfileFromPref() async {
  //   emit(const EditProfileState.loading());
  //   final prefs = await SharedPreferences.getInstance();
  //   String? userJson = prefs.getString('user');
  //   if (userJson != null) {
  //     User user = User.fromJson(jsonDecode(userJson));
  //     emit(EditProfileState.success(user: user));
  //   } else {
  //     emit(EditProfileState.error(appException: CustomException('User not found')));
  //   }
  // }

  updateUserProfile({User? user, File? imageFile}) async {
    emit(const EditProfileState.loading());
    String? imageUrl;
    if (imageFile != null) {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      var response = await _userRepository.updateUserPhoto(base64Image);
      response.fold((left) {
        emit(EditProfileState.error(appException: left));
        return;
      }, (right) {
        imageUrl = right;
      });
    }
    if (user != null) {
      var response = await _userRepository.updateUser(user);
      response.fold((left) {
        emit(EditProfileState.error(appException: left));
        return;
      }, (right) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user', jsonEncode(right.toJson()));
        emit(EditProfileState.success(user: right));
        return;
      });
    } else {
      // update imageurl in user stored in pref
      final prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');
      if (userJson != null) {
        User user = User.fromJson(jsonDecode(userJson)).copyWith(photoURL: imageUrl);
        prefs.setString('user', jsonEncode(user.toJson()));
        emit(EditProfileState.success(user: user));
        return;
      } else {
        emit(EditProfileState.error(appException: CustomException('User not found')));
        return;
      }
    }
  }
}
