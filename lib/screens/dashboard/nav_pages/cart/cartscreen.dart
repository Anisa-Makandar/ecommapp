import 'package:ecommapp/data/models/viewcart_data_model.dart';
import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/bloc/fetch_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/bloc/fetch_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/bloc/fetch_state.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/delete_bloc/delete_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/delete_bloc/delete_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/delete_bloc/delete_state.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/createorder/placeorderpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController applyController = TextEditingController();
  bool isLoading = false;
  num totalBill = 0.0;
  num subTotal = 0.0;
  num totalAfterCGST = 0.0;
  num totalAfterSGST = 0.0;
  double cgst = 0.12;
  double sgst = 0.20;
  num discountper = 0.20;
  num totalDiscount = 0.0;
  @override
  void initState() {
    super.initState();
    context.read<FetchCartBloc>().add(FetchMyCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xEFF5F5F5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: CustumCircleActar(
                  //     icon: Icons.arrow_back,
                  //     backgroundColor: Colors.white,
                  //     size: 60.0,
                  //   ),
                  // ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'My Cart',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  // Wrap ListView.builder in Expanded
                  child: BlocBuilder<FetchCartBloc, FetchCartState>(
                builder: (_, state) {
                  if (state is FetchCartLoadingState) {
                    isLoading = true;
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is FetchCartErrorState) {
                    return Center(child: Text(state.errorMsg));
                  }
                  if (state is FetchCartLoadedState) {
                    updateBill(state.mData.data!);

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.mData.data!.length,
                            itemBuilder: (_, index) {
                              CartModel eachItem = state.mData.data![index];
                              return getCartItemWidget(
                                imgUrl: eachItem.image!,
                                productName: eachItem.name!,
                                braandName: eachItem.product_id!.toString(),
                                price: eachItem.price!,
                                quantity: eachItem.quantity!,
                                // cartId: eachItem.id, // Pass the cartId here
                              );
                            },
                          ),
                        ),
                        gettotalContainer(),
                      ],
                    );
                  }
                  return Container();
                },
              )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateBill(List<CartModel> cartItem) {
    subTotal = 0.0;
    totalBill = 0.0;
    for (CartModel eachItem in cartItem) {
      subTotal += (double.parse(eachItem.price!) * eachItem.quantity!);
    }
    //discount
    totalBill = subTotal - subTotal * discountper;
    totalDiscount = subTotal * discountper;
    // tax
    totalAfterCGST = totalBill * cgst;
    totalBill += totalAfterCGST;
    totalAfterSGST = totalBill * sgst;
    totalBill += totalAfterSGST;
  }

  Widget gettotalContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(31),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextfieldWidget(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style:
                      TextStyle(fontSize: 18, color: const Color(0xFFA0A0A0)),
                ),
                Text(
                  '\$${subTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF040D18),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discount(${discountper * 100}%)',
                  style:
                      TextStyle(fontSize: 18, color: const Color(0xFFA0A0A0)),
                ),
                Text(
                  '- \$${totalDiscount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF040D18),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax(CGST - ${cgst * 100}%)',
                  style:
                      TextStyle(fontSize: 18, color: const Color(0xFFA0A0A0)),
                ),
                Text(
                  '+ \$${totalAfterCGST.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF040D18),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax(SGST - ${sgst * 100}%)',
                  style:
                      TextStyle(fontSize: 18, color: const Color(0xFFA0A0A0)),
                ),
                Text(
                  '+ \$${totalAfterSGST.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF040D18),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                color:
                    Colors.grey, // You can change the color to suit your design
                thickness: 2, // Adjust the thickness of the line
                indent: 0, // Space before the divider starts
                endIndent: 0, // Space after the divider ends
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'total',
                  style:
                      TextStyle(fontSize: 16, color: const Color(0xFF3A4147)),
                ),
                Text(
                  '\$${totalBill}',
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF040D18),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: CustomButton(
                width: double.infinity,
                text: 'Checkout',
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Placeorderpage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextfieldWidget() {
    return TextField(
      controller: applyController,
      decoration: InputDecoration(
        hintText: 'Enter Discount Code',
        fillColor: const Color(0xD9F5F5F5),
        filled: true, // Ensures the background color is filled
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent), // Makes border color transparent
          borderRadius:
              BorderRadius.circular(25), // Adjust the radius of the text field
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent), // Focused border color is transparent
          borderRadius: BorderRadius.circular(
              25), // Same border radius for focused border
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent), // Enabled border color is transparent
          borderRadius: BorderRadius.circular(
              25), // Same border radius for enabled border
        ),
        // Use `suffixIcon` to keep the "Apply" text visible all the time
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Apply',
            style: TextStyle(fontSize: 20, color: Colors.orange),
          ),
        ),
      ),
    );
  }

  Widget getCartItemWidget({
    required String imgUrl,
    required String productName,
    required String braandName,
    required String price,
    // required int cartId,
    required int quantity,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
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
                      onPressed: () {
                        // context
                        //     .read<DeleteBloc>()
                        //     .add(DeleteOrderEvent(cartId: ));
                      },
                      icon: const Icon(Icons.delete_outline,
                          color: Color(0xFFFB6915)),
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
                    getCountWidget(quantity),
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

  Widget getCountWidget(int quantity) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Container(
        width: 100,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xEFF5F5F5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 16,
                ),
              ),
              Text(
                '$quantity',
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.add,
                color: Colors.black,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getcardcontainer(String imgUrl) {
    return Container(
      height: 100,
      width: 80,
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
}
