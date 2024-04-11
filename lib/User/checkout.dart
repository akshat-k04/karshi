import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';

class CheckoutPage extends StatefulWidget {
  final String uid;
  final List<Item> cartProducts;
  final double grandTotal;

  CheckoutPage(
      {required this.uid,
      required this.cartProducts,
      required this.grandTotal});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  CustomerData? user = null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    fetchData();
  }

  void fetchData() async {
    user = await CustomerService(uid: widget.uid).getUserData();
    _nameController.text = user!.customer_name;
    _addressController.text = user!.customer_address;
    // print(user.mobile_number);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Customer Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              readOnly: true,
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 8.0),
            TextField(
              readOnly: true,
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Delivery Address'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Products:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, index) {
                  final product = widget.cartProducts[index];
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
            Text(
              'Grand Total: \$${widget.grandTotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                // Add your logic for checkout
                dynamic result = await CustomerService(uid: widget.uid).buyItems();
                print('Place Order');
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
