import 'package:ecommapp/data/models/profile_data_model.dart';
import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/profile/bloc/profile_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  ApiHelper apiHelper;
  UserProfileBloc({required this.apiHelper})
      : super(UserProfileInitialState()) {
    on<GetUserProfileEvent>((event, emit) async {
      try {
        var res = await apiHelper.postAPI(url: Urls.USER_PROFILE_URL);
        print("API Response: $res");

        if (res["status"] == "true" || res["status"] == true) {
          emit(UserProfileLoadedState(data: UserDataModel.fromJson(res)));
        } else {
          emit(UserProfileErrorState(
              errorMsg: res["message"] ?? "Unknown error"));
        }
      } catch (e) {
        print("Error: $e");
        emit(UserProfileErrorState(errorMsg: e.toString()));
      }
    });
  }
}
