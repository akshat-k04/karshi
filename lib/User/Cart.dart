import 'package:flutter/material.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/User/checkout.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';

class AddToCartPage extends StatefulWidget {
  String uid;
  AddToCartPage({required this.uid});

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  double grandTotal = 0.0;
  List<Item> cart_product = [];
  @override
  void initState() {
    super.initState();
    fetchData();
    // () async =>
    //     {cart_product = await CustomerService(uid: widget.uid).getCart()};
    // calculateGrandTotal();
  }

  void calculateGrandTotal() {
    print(cart_product);
    grandTotal = cart_product.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.stock));
  }

  void fetchData() async {
    cart_product = await CustomerService(uid: widget.uid).getCart();
    calculateGrandTotal();
    // Since we updated the state, we need to call setState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Cart',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: cart_product.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                      product_details: (cart_product)[index], isfavorite: true);
                },
              ),
            ),
            Text(
                'Grand Total:                                                   \$${grandTotal.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Add your logic for checkout
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CheckoutPage(
                            uid: widget.uid,
                            cartProducts: cart_product,
                            grandTotal: grandTotal),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
                print('Checkout');
              },
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10.0)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(MyAppColors.bgGreen),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Color.fromARGB(
                          255, 66, 184, 113), // Set border color here
                      width: 1.0, // Set border width here
                    ),
                  ),
                ),
              ),
              child: Text(
                'Proceed to buy',
                style: TextStyle(color: MyAppColors.textColor, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
