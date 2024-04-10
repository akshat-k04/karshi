import 'package:flutter/material.dart';
import 'package:karshi/User/Product_details.dart';

class WishlistPage extends StatelessWidget {
  final List<String> wishlistItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          return ProductItem();
        },
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Product Name', // Replace with actual product name
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  // Add your function here
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ProductDetailsPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );

                  print('Image clicked!');
                },
                child: Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/images/temp.png"), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Add to wishlist logic
                },
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Add to cart logic
                  setState(() {
                    quantity = 1;
                  });
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
