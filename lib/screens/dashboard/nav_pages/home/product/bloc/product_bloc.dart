import 'package:ecommapp/data/models/product_data_model.dart';
import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/data/remote/urls.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/home/product/bloc/product_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/home/product/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ApiHelper apiHelper;
  ProductBloc({required this.apiHelper}) : super(ProductInitialState()) {
    on<GeetAllProductEvent>((event, emit) async {
      emit(ProductLoadingState());

      try {
        var res = await apiHelper.postAPI(url: Urls.GET_PRODUCT_URL);

        if (res['status']) {
          emit(ProductLoadedState(mData: ProductDataModel.fromJson(res)));
        }
      } catch (e) {
        emit(ProductErrorState(errorMsg: e.toString()));
      }
    });
  }
}
