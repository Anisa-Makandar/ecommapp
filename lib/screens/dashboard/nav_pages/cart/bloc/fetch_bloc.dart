import 'package:ecommapp/data/models/viewcart_data_model.dart';
import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/bloc/fetch_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/bloc/fetch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchCartBloc extends Bloc<FetchCartEvent, FetchCartState> {
  ApiHelper apiHelper;
  FetchCartBloc({required this.apiHelper}) : super(FetchCartInitalState()) {
    on<FetchCartEvent>((event, emit) async {
      emit(FetchCartLoadingState());
      try {
        var res = await apiHelper.getAPI(url: Urls.VIEW_TO_CART_URL);

        if (res["status"] == "true" || res["status"]) {
          emit(FetchCartLoadedState(mData: CartDataModel.fromJson(res)));
        } else {
          emit(FetchCartErrorState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(FetchCartErrorState(errorMsg: e.toString()));
      }
    });
  }
}
