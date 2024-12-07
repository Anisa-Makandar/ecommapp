import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/register/bloc/register_user_event.dart';
import 'package:ecommapp/screens/register/bloc/register_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  ApiHelper apiHelper;
  RegisterUserBloc({required this.apiHelper})
      : super(RegisterUserInitialState()) {
    on<CreateUserEvent>((event, emit) async {
      emit(RegisterUserLoadingState());
      try {
        var res = await apiHelper.postAPI(
            url: Urls.REGISTER_URL,
            isHeaderRequired: false,
            mBodyParams: {
              "name": event.name,
              "mobile_number": event.mobNo,
              "email": event.email,
              "password": event.pass,
            });
        print(res);
        if (res["status"] == true) {
          emit(RegisterUserSuccessState());
          print("Status: ${res['status']}");
        } else {
          // emit(RegisterUserFailureState(errorMsg: res["message"]));
          emit(RegisterUserFailureState(
              errorMsg: res['message'] ?? "Unknown error"));
          print("Message: ${res['message']}");
        }
      } catch (e) {
        emit(RegisterUserFailureState(errorMsg: e.toString()));
        print(e);
      }
    });
  }
}
