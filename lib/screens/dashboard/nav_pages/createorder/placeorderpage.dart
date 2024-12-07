import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/domain/custom_circleavtar.dart';
import 'package:ecommapp/screens/dashboard/bottomnavigation.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/createorder/bloc/create_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/createorder/bloc/create_order_event.dart';

class Placeorderpage extends StatefulWidget {
  @override
  _PlaceorderpageState createState() => _PlaceorderpageState();
}

class _PlaceorderpageState extends State<Placeorderpage> {
  bool isCodExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xEFF5F5F5),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CustumCircleActar(
                        icon: Icons.arrow_back,
                        backgroundColor: Colors.white,
                        size: 32,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Payments',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Payment Options Section using Rows and Dividers
                Expanded(
                  child: Column(
                    children: [
                      buildPaymentRow(
                        icon: Icons.account_balance,
                        optionName: "Net Banking",
                      ),
                      Divider(thickness: 1),
                      buildPaymentRow(
                        icon: Icons.account_balance_wallet,
                        optionName: "Wallet",
                      ),
                      Divider(thickness: 1),
                      buildPaymentRow(
                        icon: Icons.payment,
                        optionName: "UPI",
                      ),
                      Divider(thickness: 1),
                      buildCodPaymentRow(),
                      Divider(thickness: 1),
                      SizedBox(height: 15),
                      Text(
                        "Happy Customers",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w700),
                      ),
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// A reusable widget for each payment option row
  Widget buildPaymentRow({required IconData icon, required String optionName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              optionName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget buildCodPaymentRow() {
    return Column(
      children: [
        // Main row for Cash on Delivery
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          child: Row(
            children: [
              Icon(Icons.local_shipping, size: 32, color: Colors.blueAccent),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Cash on Delivery",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                icon: Icon(
                  isCodExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                onPressed: () {
                  // Toggle the dropdown
                  setState(() {
                    isCodExpanded = !isCodExpanded;
                  });
                },
              ),
            ],
          ),
        ),
        // Dropdown container for Cash on Delivery details
        if (isCodExpanded)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You have chosen Cash on Delivery.",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        width: 200,
                        height: 40,
                        text: 'Place Order',
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                        onPressed: () {
                          // Trigger BLoC event for order confirmation
                          context.read<CreateOrder>().add(CreateOrderEvent(
                                message: "Order placed successfully!",
                                status: true,
                              ));

                          // Show order confirmation bottom sheet
                          showOrderConfirmationBottomSheet(
                            context,
                            "Are you sure you want to confirm your order?",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void showOrderConfirmationBottomSheet(
      BuildContext context, String apiMessage) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Confirm Cash on Delivery Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: CustomButton(
                      width: 140,
                      height: 40,
                      text: 'Cancel',
                      textStyle: TextStyle(fontSize: 14, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      width: 140,
                      height: 40,
                      text: 'Confirm Order',
                      textStyle: TextStyle(fontSize: 14, color: Colors.white),
                      borderRadius:
                          BorderRadius.circular(12), // Adjust border radius

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavifationPage()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Order Confirmed!"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
