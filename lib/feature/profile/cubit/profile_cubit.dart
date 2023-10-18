import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/user.dart';
import 'package:native/model/user_prefs.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(const ProfileState.initial());

  final UserRepository _userRepository;

  // void getProfile() async {
  //   var user = await _userRepository.getCurrentUserDetails();
  //   user.fold((left) {
  //     emit(ProfileState.error(exception: left));
  //   }, (right) {
  //     emit(ProfileState.userDetails(user: right));
  //   });
  // }

  bool validateBasicDetails(String displayName, String about, String? location) {
    //validate info
    if (displayName.isEmpty) {
      return false;
    }
    if (about.isEmpty) {
      return false;
    }
    if (location?.isEmpty ?? true) {
      return false;
    }
    return true;
  }

  bool validateOtherDetails(String? religion, String? community) {
    //validate info
    if (religion?.isEmpty ?? true) {
      return false;
    }
    if (community?.isEmpty ?? true) {
      return false;
    }
    return true;
  }

  void updateProfile(User user) async {
    emit(const ProfileState.loading());
    var response = await _userRepository.updateUser(user);
    response.fold((left) {
      emit(ProfileState.error(exception: left));
    }, (right) {
      emit(const ProfileState.profileUpdated());
    });
  }
  
  void updateOtherDetails(User user) async {
    emit(const ProfileState.loading());
    var response = await _userRepository.updateUser(user);
    response.fold((left) {
      emit(ProfileState.error(exception: left));
    }, (right) {
      emit(const ProfileState.otherDetailsUpdated());
    });
  }

  // void updateUserBirthdateFetchNativeCard(User user) async {
  //   emit(const ProfileState.loading());
  //   var response = await _userRepository.updateUser(user);
  //   response.fold((left) {
  //     emit(ProfileState.error(exception: left));
  //   }, (right) {
  //     emit(const ProfileState.profileUpdated());
  //   });
  // }

  void updateUserPrefrences(UserPrefs userPrefs) async {
    emit(const ProfileState.loading());
    var response = await _userRepository.updateUserPrefs(userPrefs);
    response.fold((left) {
      emit(ProfileState.error(exception: left));
    }, (right) {
      emit(const ProfileState.profileUpdated());
    });
  }

  void updateProfilePhoto(File imageFile) async {
    emit(const ProfileState.loading());
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    var response = await _userRepository.updateUserPhoto(base64Image);
    response.fold((left) {
      emit(ProfileState.error(exception: left));
    }, (right) {
      emit(ProfileState.photoUpdated(right));
    });
  }
}
