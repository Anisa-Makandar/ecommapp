import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/detail/bloc/cart_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/detail/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ApiHelper apiHelper;
  CartBloc({required this.apiHelper}) : super(CartInitialState()) {
    on<AddToCartEvent>(
      (event, emit) async {
        emit(CartLoadingState());
        try {
          var res =
              await apiHelper.postAPI(url: Urls.ADD_TO_CART, mBodyParams: {
            "product_id": event.productId,
            "quantity": event.quantity,
          });

          if (res["status"] is bool && res["status"] == true) {
            emit(CartSuccessState());
          } else if (res["status"] is String &&
              res["status"].toLowerCase() == "true") {
            emit(CartSuccessState());
          } else {
            emit(CartFailureState(errorMsg: res["message"]));
          }
        } catch (e) {
          emit(CartFailureState(errorMsg: e.toString()));
        }
      },
    );
  }
}
