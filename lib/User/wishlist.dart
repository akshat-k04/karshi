import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karshi/User/Product_details.dart';
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
      ),
      body: ListView.builder(
        itemCount: widget.wishlist.length,
        itemBuilder: (context, index) {
          return ProductItem(productinfo: widget.wishlist[index]);
        },
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  Item productinfo;
  ProductItem({required this.productinfo});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 1;
  bool isFavorite = true;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

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
            widget.productinfo.item_name, // Replace with actual product name
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
                  // Navigator.push(
                  //   context,
                  //   PageRouteBuilder(
                  //     transitionDuration: Duration(milliseconds: 500),
                  //     pageBuilder: (context, animation, secondaryAnimation) =>
                  //         ProductDetailsPage(),
                  //     transitionsBuilder:
                  //         (context, animation, secondaryAnimation, child) {
                  //       return FadeTransition(
                  //         opacity: animation,
                  //         child: child,
                  //       );
                  //     },
                  //   ),
                  // );

                  print('Image clicked!');
                },
                child: Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image:  DecorationImage(
                      image: NetworkImage(widget.productinfo.image_url), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: isFavorite
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  // Add to wishlist logic
                  if (!isFavorite) {
                    dynamic result =
                        CustomerService(uid: user!.uid).addToWishlist(
                      widget.productinfo.item_name,
                      widget.productinfo.description,
                      widget.productinfo.price,
                      widget.productinfo.image_url,
                      widget.productinfo.stock,
                      widget.productinfo.category,
                    );
                  } else {
                    dynamic result =
                        CustomerService(uid: user!.uid).removeFromWishlist(
                      widget.productinfo.item_name,
                      widget.productinfo.description,
                      widget.productinfo.price,
                      widget.productinfo.image_url,
                      widget.productinfo.stock,
                      widget.productinfo.category,
                    );
                  }
                  setState(() {
                    isFavorite = !isFavorite;
                  });
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
                  dynamic result = CustomerService(uid: user!.uid).addToCart(
                    widget.productinfo.item_name,
                    widget.productinfo.description,
                    widget.productinfo.price,
                    widget.productinfo.image_url,
                    quantity,
                    widget.productinfo.category,
                  );
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
