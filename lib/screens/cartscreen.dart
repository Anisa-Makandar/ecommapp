import 'package:ecommapp/domain/constants.dart';
import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/domain/custom_circleavtar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final TextEditingController applyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xEFF5F5F5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustumCircleActar(
                    icon: Icons.arrow_back,
                    backgroundColor: Colors.white,
                    size: 32,
                  ),
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
                child: ListView.builder(
                  itemCount: AppConstants.getcartDetails.length,
                  itemBuilder: (_, index) {
                    final product = AppConstants.getcartDetails[index];
                    return getCartItemWidget(
                      imgUrl: product['imgUrl'],
                      productName: product['prodname'],
                      braandName: product['brand'],
                      price: product['price'],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              gettotalContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget gettotalContainer() {
    return Container(
      height: 300,
      width: double.infinity,
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
                  '\$245.00',
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
                  '\$245.00',
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
                onPressed: () {},
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
                      onPressed: () {},
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
                    getCountWidget(),
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

  Widget getCountWidget() {
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
                '1',
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
        child: Image.asset(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
