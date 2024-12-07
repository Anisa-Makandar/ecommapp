import 'package:ecommapp/data/models/product_data_model.dart';
import 'package:ecommapp/domain/constants.dart';
import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/domain/custom_circleavtar.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/detail/detailscreen.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/home/product/bloc/product_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/home/product/bloc/product_event.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/home/product/bloc/product_state.dart';
import 'package:ecommapp/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GeetAllProductEvent());
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token"); // Clear the token
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()), // Navigate to LoginPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustumCircleActar(
                      icon: Icons.more_horiz,
                      size: 60.0,
                    ),
                    CustumCircleActar(
                      icon: Icons.notifications_none_outlined,
                      size: 60.0,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 16,
                      ), // Search icon
                      hintText: 'Search...',
                      hintStyle: TextStyle(fontSize: 14), // Placeholder text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                    ),
                  ),
                ),
                getSaleContainer(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppConstants.colorData.length,
                    itemBuilder: (_, index) {
                      var colorItem = AppConstants.prodData[index];
                      // Check if dark mode is active
                      bool isDarkMode =
                          Theme.of(context).brightness == Brightness.dark;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 27,
                              backgroundImage: AssetImage(colorItem['image']),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              colorItem['productname'], // Product name
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black, // Conditional text color
                              ),
                              textAlign:
                                  TextAlign.center, // Align text to the center
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                //2
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Special For You',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Sell all',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                BlocBuilder<ProductBloc, ProductState>(builder: (_, state) {
                  if (state is ProductLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductErrorState) {
                    return Center(
                      child: Text(
                        state.errorMsg,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  } else if (state is ProductLoadedState) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.mData.data!.length,
                        itemBuilder: (_, index) {
                          DataModel cardData = state.mData.data![index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      currentProduct: state.mData.data![index],
                                    ),
                                  ));
                            },
                            child: getCategoriesWidget(
                              cardData
                                  .image!, // Use the correct key for image URL
                              cardData.name!,
                              cardData.price!, // Pass the price
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 11,
                          crossAxisSpacing: 11,
                          childAspectRatio: 1.5 / 2,
                        ),
                      ),
                    );
                  }

                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategoriesWidget(String imgUrl, String title, String price) {
    return Container(
      height: 100,
      width: 200,
      child: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              color: const Color(0xFFF5F5F5),
              image: DecorationImage(
                image: NetworkImage(imgUrl), // Use AssetImage for local images
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay with text
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Top-right container with wishlist icon
          Positioned(
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(21),
                  bottomLeft: Radius.circular(5),
                ),
                color: const Color(0xFFFF660E),
              ),
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          // Centered text
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${price}', // Display the price
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//getcontainer
  Widget getSaleContainer() {
    return Container(
      height: 230, // Container height remains fixed
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage('assets/images/item-15.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Super Sale\nDiscount",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
              text: TextSpan(
                  text: 'up to ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: '50% ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]),
            ),
            const SizedBox(height: 10),
            CustomButton(
              width: 100,
              height: 30,
              text: 'Shop Now',
              textStyle: TextStyle(fontSize: 12, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
