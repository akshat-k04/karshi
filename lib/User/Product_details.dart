import 'package:flutter/material.dart';
import 'package:karshi/backend/models/models.dart';

class ProductDetailsPage extends StatefulWidget {
  Item product_detail;
  ProductDetailsPage({required this.product_detail});
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // Example product data
  // String productName =widget.product_detail.item_name;
  // String productImageUrl = 'https://example.com/product-image.jpg';
  // double productPrice = 100.0;
  // String productCategory = 'Product Category';
  // String productDescription =
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
  //     'Pellentesque commodo mauris sit amet diam tristique, '
  //     'et lacinia lorem dictum. Integer fermentum vulputate metus, '
  //     'et aliquet metus faucibus at. Vivamus lacinia interdum purus, '
  //     'quis cursus nisl condimentum a. Ut nec diam eleifend, '
  //     'consequat risus sed, hendrerit libero.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product_detail.item_name),
        automaticallyImplyLeading: false, // Remove the back button icon
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Image.network(
            widget.product_detail.image_url,
            height: 200,
            fit: BoxFit.cover,
          ),
          // const Image(image: AssetImage("assets/images/temp.png")),
          const SizedBox(height: 16.0),

          Text(
            'Price: \$${widget.product_detail.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.product_detail.category,
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
            widget.product_detail.description,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
