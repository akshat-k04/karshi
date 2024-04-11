import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final int quantity;

  Product(this.name, this.price, this.quantity);
}

class AddToCartPage extends StatefulWidget {
  final List<Product> products;

  AddToCartPage({required this.products});

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  double grandTotal = 0.0;

  @override
  void initState() {
    super.initState();
    calculateGrandTotal();
  }

  void calculateGrandTotal() {
    grandTotal = widget.products.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
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
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  final totalPrice = product.price * product.quantity;
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                        'Price: \$${product.price} Quantity: ${product.quantity} Total: \$${totalPrice.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text('Grand Total: \$${grandTotal.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                // Add your logic for checkout
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

