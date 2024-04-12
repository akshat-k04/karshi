import 'package:flutter/material.dart';
import 'package:karshi/User/Cart.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/app_colors.dart';

class ProductDetailsPage extends StatefulWidget {
  Item product_detail;
  ProductDetailsPage({required this.product_detail});
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  get user => null;

  @override
  Widget build(BuildContext context) {
    var quantity = 0;
    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Krishi',
          style: TextStyle(
            color: MyAppColors.textColor, // Text color set to white
            fontSize: 36.0, // Choose the size that fits your design
            fontWeight: FontWeight.bold, // Text weight set to bold
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back button icon
        backgroundColor: MyAppColors.backgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Product Details',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Image.network(
            widget.product_detail.image_url,
            height: 200,
            fit: BoxFit.cover,
          ),
          // const Image(image: AssetImage("assets/images/temp.png")),
          const SizedBox(height: 16.0),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.product_detail.item_name,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${widget.product_detail.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product_detail.category,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star_half, color: Colors.amber, size: 20),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 36.0),
          const Text(
            'Product Description:',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.product_detail.description,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          SizedBox(
            height: 300,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Adjusts spacing between items
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyAppColors.backgroundColor,
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 100), // Made wider
                  decoration: BoxDecoration(
                    color: MyAppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '$quantity',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyAppColors.backgroundColor,
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

// The "Add to Cart" container
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 40,
                  ),
                  color: MyAppColors.textColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            AddToCartPage(uid: user!.uid),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
                Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: MyAppColors.textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
