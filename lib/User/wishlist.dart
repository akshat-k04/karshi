import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/User/Product_details.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  List<Item> wishlist;
  WishlistPage({required this.wishlist});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor:
            MyAppColors.bgGreen, // Example background color for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Products",
                style: TextStyle(
                  color: Colors
                      .white, // Ensure this is visible against your app's theme
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Adjusted for better visual balance
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: widget.wishlist.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product_details: widget.wishlist[index],
                    isfavorite: true,
                    // Assuming you have such a parameter
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
