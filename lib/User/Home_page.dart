import 'dart:ffi';
import 'package:karshi/app_colors.dart';
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
  String uid;
  HomePage({super.key, required this.uid});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Item> show_products = [];

  @override
  void initState() {
    // TODO: implement initState
    fetch();
    super.initState();
  }

  void fetch() async {
    show_products = await CustomerService(uid: widget.uid).getAllItems();
    setState(() {});
  }

  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    List<Item> filter_products(String value) {
      if (value == "") return show_products;

      List<Item> filtered_product = [];
      for (Item product in show_products) {
        if (product.category.contains(value) ||
            product.description.contains(value) ||
            product.item_name.contains(value)) {
          filtered_product.add(product);
        }
      }
      return filtered_product;
    }

    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColors.backgroundColor,
        title: Text(
          'Krishi',
          style: TextStyle(
            color: MyAppColors.textColor, // Text color set to white
            fontSize: 36.0, // Choose the size that fits your design
            fontWeight: FontWeight.bold, // Text weight set to bold
          ),
        ),
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
                      ProfilePage(uid: user!.uid),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Products',
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: MyAppColors.bgGreen,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: MyAppColors.textColor,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyAppColors.textColor),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Space between search bar and buttons
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 40,
                    ),
                    color: MyAppColors.textColor,
                    onPressed: () {
                      // View cart logic
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                  SizedBox(width: 10), // Space between two buttons
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 40,
                    ),
                    color: MyAppColors.textColor,
                    onPressed: () async {
                      // Wishlist logic
                      List<Item> wishlist_user =
                          await CustomerService(uid: user!.uid).getWishlist();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  WishlistPage(wishlist: wishlist_user),
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
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding:
                  EdgeInsets.only(left: 20.0), // Adjust the value to your needs
              child: Text(
                "Products",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: show_products.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        color: MyAppColors.bgGreen,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: MyAppColors.bgGreen,
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
    final user = Provider.of<UserAuth?>(context);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            color: MyAppColors.bgGreen,
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
          child: Row(
            children: [
              Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.product_details.image_url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product_details.item_name,
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        widget.product_details.description,
                        style: TextStyle(
                            fontSize: 20.0, color: MyAppColors.textColor),
                      ),
                      Text(
                        "★★★★☆",
                        style: TextStyle(color: Colors.yellowAccent),
                      ), // Placeholder for rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              dynamic result =
                                  CustomerService(uid: user!.uid).addToCart(
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ),
        Positioned(
          right: 10,
          top: 50,
          child: Text(
            '\$${widget.product_details.price}', // Assuming you have a price field
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
