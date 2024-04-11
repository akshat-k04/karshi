import 'package:flutter/material.dart';
import 'package:karshi/User/checkout.dart';
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
      appBar: AppBar(
        title: Text('Add to Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: cart_product.length,
                itemBuilder: (context, index) {
                  final product = cart_product[index];
                  final totalPrice = product.price * product.stock;
                  return ListTile(
                    title: Text(product.item_name),
                    subtitle: Text(
                        'Price: \$${product.price} Quantity: ${product.stock} Total: \$${totalPrice.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text('Grand Total: \$${grandTotal.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                // Add your logic for checkout
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CheckoutPage(uid: widget.uid,cartProducts: cart_product,grandTotal:grandTotal),
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
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
