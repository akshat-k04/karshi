import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // Example product data
  String productName = 'Product Name';
  String productImageUrl = 'https://example.com/product-image.jpg';
  double productPrice = 100.0;
  String productCategory = 'Product Category';
  String productDescription =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Pellentesque commodo mauris sit amet diam tristique, '
      'et lacinia lorem dictum. Integer fermentum vulputate metus, '
      'et aliquet metus faucibus at. Vivamus lacinia interdum purus, '
      'quis cursus nisl condimentum a. Ut nec diam eleifend, '
      'consequat risus sed, hendrerit libero.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        automaticallyImplyLeading: false, // Remove the back button icon
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Image.network(
          //   productImageUrl,
          //   height: 200,
          //   fit: BoxFit.cover,
          // ),
          const Image(image: AssetImage("assets/images/temp.png")),
          const SizedBox(height: 16.0),
          
          Text(
            'Price: \$${productPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            productCategory,
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Description:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            productDescription,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
