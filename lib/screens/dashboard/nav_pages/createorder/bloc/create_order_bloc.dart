import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/createorder/bloc/create_order_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/createorder/bloc/create_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrder extends Bloc<CreateOrderEvent, CreateOrderState> {
  ApiHelper apiHelper;
  CreateOrder({required this.apiHelper}) : super(CreateOrderInitialState()) {
    on<CreateOrderEvent>((event, emit) async {
      emit(CreateOrderLoadingState());
      try {
        var res =
            await apiHelper.postAPI(url: Urls.CREATE_ORDER_URL, mBodyParams: {
          "status": event.status,
          "message": event.message,
        });
        if (res['status'] == true) {
          emit(CreateOrderSuccessState());
        } else {
          emit(CreateOrderFailureState(
              errorMsg: res['message'] ?? "An error occurred."));
        }
      } catch (e) {
        emit(CreateOrderFailureState(errorMsg: e.toString()));
      }
    });
  }
}
