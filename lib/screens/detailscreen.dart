import 'package:ecommapp/domain/custom_circleavtar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xEFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustumCircleActar(
                  icon: Icons.notifications_none_outlined,
                  backgroundColor: Colors.white,
                  size: 60.0,
                ),
              ],
            ),
            CustumCircleActar(
              icon: Icons.share,
              size: 60.0,
              backgroundColor: Colors.white,
            ),
            CustumCircleActar(
              icon: Icons.favorite_border,
              size: 60.0,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
