import 'package:ecommapp/domain/constants.dart';

import 'package:ecommapp/domain/custom_button.dart';
import 'package:ecommapp/domain/custom_circleavtar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xEFF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CustumCircleActar(
                        icon: Icons.arrow_back_ios,
                        backgroundColor: Colors.white,
                        size: 60.0,
                      ),
                    ),
                    Row(
                      children: [
                        CustumCircleActar(
                          icon: Icons.share,
                          size: 60.0,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CustumCircleActar(
                          icon: Icons.favorite_border,
                          size: 60.0,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 240,
                  width: 260,
                  child: Image.asset(
                    'assets/images/headphone_img.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(31),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wireless Headphone',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '\$520.00', // Display the price
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Seller: Tariqual isalm ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFFFF660E),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '(320 Review)',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Color',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppConstants.colorData.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0,
                                  right:
                                      index == AppConstants.colorData.length - 1
                                          ? 5
                                          : 0),
                              child: InkWell(
                                child: getColorToneWidget(
                                    // Use the correct key for product name
                                    AppConstants.colorData[index]
                                        ['color']), // Pass the price
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              width: 100,
                              height: 35,
                              text: 'Description',
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              onPressed: () {}),
                          // Text('Description'),
                          Text(
                            'Specifications',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Reviews',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          'Lorem ipsum is typically a corrupted version of De finibus bonorum et malorum altered, added, and removed to make it nonsensical and improper Latin. '),
                      getAddCardButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getColorToneWidget(Color colorData) {
    return CircleAvatar(
      radius: 20, // Adjust size
      backgroundColor: colorData,
    );
  }

  Widget getCountWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Text(
                '1',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAddCardButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getCountWidget(),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: CustomButton(
                    text: 'Add to Cart',
                    textStyle: TextStyle(fontSize: 18, color: Colors.white),
                    onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
