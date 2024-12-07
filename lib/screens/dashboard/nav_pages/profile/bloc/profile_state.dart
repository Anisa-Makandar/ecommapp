import 'package:ecommapp/data/models/profile_data_model.dart';

abstract class UserProfileState {}

class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileLoadedState extends UserProfileState {
  UserDataModel data;
  UserProfileLoadedState({required this.data});
}

class UserProfileErrorState extends UserProfileState {
  String errorMsg;
  UserProfileErrorState({required this.errorMsg});
}
