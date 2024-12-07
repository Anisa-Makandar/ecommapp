import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/login/bloc/login_user_event.dart';
import 'package:ecommapp/screens/login/bloc/login_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  ApiHelper apiHelper;
  LoginUserBloc({required this.apiHelper}) : super(LoginUserInitialState()) {
    on<AuthenticateUser>((event, emit) async {
      emit(LoginUserLoadingState());

      try {
        var res = await apiHelper.postAPI(
            url: Urls.LOGIN_URL,
            isHeaderRequired: false,
            mBodyParams: {
              "email": event.email,
              "password": event.pass,
            });

        if (res["status"]) {
          emit(LoginUserSuccessState());
          String token = res["tokan"];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", token);
        } else {
          emit(LoginUserFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(LoginUserFailureState(errorMsg: e.toString()));
      }
    });
  }
}
