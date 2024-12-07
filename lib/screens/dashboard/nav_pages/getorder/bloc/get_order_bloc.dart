import 'package:ecommapp/data/models/getcart_data_model.dart';
import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/getorder/bloc/get_order_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/getorder/bloc/get_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllOrderBloc extends Bloc<GetAllOrderEvent, GetAllOrderState> {
  final ApiHelper apiHelper;

  GetAllOrderBloc({required this.apiHelper}) : super(GetOrderInitialState()) {
    on<getAllMyPlacedOrder>(_onGetAllMyPlacedOrder);
  }

  Future<void> _onGetAllMyPlacedOrder(
      getAllMyPlacedOrder event, Emitter<GetAllOrderState> emit) async {
    emit(GetOrderLoadingState());

    try {
      final Map<String, dynamic> res =
          await apiHelper.postAPI(url: Urls.Get_ORDER_URL);

      bool isSuccess = res["status"] == true;
      print(res["status"]);

      if (isSuccess) {
        emit(GetOrderLoadedState(
            order: GetOrderDataModel.fromJson(res).orders!));
      } else {
        emit(GetOrderErrorState(errorMsg: res["message"] ?? "Unknown error"));
      }
    } catch (e) {
      emit(GetOrderErrorState(errorMsg: e.toString()));
    }
  }
}
