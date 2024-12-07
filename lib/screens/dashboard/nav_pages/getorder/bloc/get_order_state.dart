import 'package:ecommapp/data/models/getcart_data_model.dart';

abstract class GetAllOrderState {}

class GetOrderInitialState extends GetAllOrderState {}

class GetOrderLoadingState extends GetAllOrderState {}

class GetOrderErrorState extends GetAllOrderState {
  String errorMsg;
  GetOrderErrorState({required this.errorMsg});
}

class GetOrderLoadedState extends GetAllOrderState {
  List<OrderModel> order;
  GetOrderLoadedState({required this.order});
}
