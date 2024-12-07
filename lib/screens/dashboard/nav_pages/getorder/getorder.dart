import 'package:ecommapp/domain/custom_circleavtar.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/getorder/bloc/get_order_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/getorder/bloc/get_order_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/getorder/bloc/get_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetAllOrderBloc>().add(getAllMyPlacedOrder());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Back Arrow at the top
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustumCircleActar(
                      icon: Icons.arrow_back,
                      backgroundColor: Colors.white,
                      size: 60.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<GetAllOrderBloc, GetAllOrderState>(
                builder: (_, state) {
                  if (state is GetOrderLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GetOrderErrorState) {
                    return Center(
                      child: Text(state.errorMsg),
                    );
                  }
                  if (state is GetOrderLoadedState) {
                    return ListView.builder(
                      itemCount: state.order.length,
                      itemBuilder: (_, orderIndex) {
                        final order = state.order[orderIndex];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order #${orderIndex + 1}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text("Order on :${order.created_at}")
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true, // Prevent layout issues
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disable nested scrolling
                                itemCount: order.product!.length,
                                itemBuilder: (_, productIndex) {
                                  final product = order.product![productIndex];
                                  return getCartItemWidget(
                                    imgUrl: product.image!,
                                    productName: product.name!,
                                    braandName: product.name!,
                                    price: product.price!,
                                    quantity: product.quantity!,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getCartItemWidget(
    {required String imgUrl,
    required String productName,
    required String braandName,
    required String price,
    required int quantity}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(8.0),
    height: 130,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        getcardcontainer(imgUrl),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ],
              ),
              Text(
                braandName,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // getCountWidget(quantity),
                ],
              ),
            ],
          ),
        ),
        // Quantity Controls and Delete Icon
      ],
    ),
  );
}

Widget getcardcontainer(String imgUrl) {
  return Container(
    height: 100,
    width: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xEFF5F5F5),
    ),
    child: Center(
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
      ),
    ),
  );
}
