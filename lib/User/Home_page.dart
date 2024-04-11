import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karshi/User/Cart.dart';
import 'package:karshi/User/Product_details.dart';
import 'package:karshi/User/profile.dart';
import 'package:karshi/User/wishlist.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  List<Item> products;
  HomePage({super.key, required this.products});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String Selected_catagory = "All";
  List<Item> show_products = [];
  List<Product> tempProducts = [
    Product('Product 1', 10.0, 2),
    Product('Product 2', 15.0, 1),
    Product('Product 3', 20.0, 3),
  ];

  

  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);
    List<Item> filter_products(String value) {
      List<Item> filtered_product = [];
      for (Item product in widget.products) {
        if (product.category.contains(value) ||
            product.description.contains(value) ||
            product.item_name.contains(value)) {
          filtered_product.add(product);
        }
      }
      return filtered_product;
    }
    setState(() {
      show_products = widget.products;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Krashi'),
        automaticallyImplyLeading: false, // Remove the back button icon
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Add profile icon onPressed logic
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ProfilePage(),
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    show_products = filter_products(value);
                  })
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: show_products.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
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
                      child:
                          ProductItem(product_details: (show_products)[index]));
                },
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // View cart logic

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AddToCartPage(products: tempProducts),
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
                    child: const Text('View Cart'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Wishlist logic

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  WishlistPage(),
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
                    child: const Text('Wishlist'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  Item product_details;
  ProductItem({required this.product_details});
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 1;
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    // print(widget.product_details);
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
            widget
                .product_details.item_name, // Replace with actual product name
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
                          ProductDetailsPage(
                              product_detail: widget.product_details),
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
                    image: DecorationImage(
                      image: NetworkImage(widget.product_details
                          .image_url), // Replace with your image
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
                      widget.product_details.item_name,
                      widget.product_details.description,
                      widget.product_details.price,
                      widget.product_details.image_url,
                      widget.product_details.stock,
                      widget.product_details.category,
                    );
                  } else {
                    dynamic result =
                        CustomerService(uid: user!.uid).removeFromWishlist(
                      widget.product_details.item_name,
                      widget.product_details.description,
                      widget.product_details.price,
                      widget.product_details.image_url,
                      widget.product_details.stock,
                      widget.product_details.category,
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
                  dynamic result = CustomerService(uid: user!.uid).addToCart(
                    widget.product_details.item_name,
                    widget.product_details.description,
                    widget.product_details.price,
                    widget.product_details.image_url,
                    quantity,
                    widget.product_details.category,
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
