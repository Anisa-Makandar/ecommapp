import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/delete_bloc/delete_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/delete_bloc/delete_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  ApiHelper apiHelper;
  DeleteBloc({required this.apiHelper}) : super(DeleteOrderInitialState()) {
    on<DeleteOrderEvent>((event, emit) async {
      emit(DeleteOrderLoadingState());
      try {
        // Perform the API call to delete the cart item
        var res = await apiHelper.postAPI(
          url: Urls.DELETE_TO_CART_URL,
          mBodyParams: {"cart_id": event.cartId},
        );

        // Check the API response status
        if (res['status'] == true) {
          emit(DeleteOrderSuccessState());
        } else {
          emit(DeleteOrderFailureState(
              errorMsg: res['message'] ?? "An error occurred."));
        }
      } catch (e) {
        // Handle any exceptions
        emit(DeleteOrderFailureState(errorMsg: e.toString()));
      }
    });
  }
}
