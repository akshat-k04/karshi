import 'package:flutter/material.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/User/Product_details.dart';
import 'package:karshi/User/checkout.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:provider/provider.dart';

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

class ProductItem extends StatefulWidget {
  Item product_details;
  bool isfavorite;

  ProductItem({
    required this.product_details,
    required this.isfavorite,
  });

  @override
  _ProductItemState createState() => _ProductItemState(
        favorite: isfavorite,
      );
}

class _ProductItemState extends State<ProductItem> {
  bool favorite;
  _ProductItemState({required this.favorite});
  int quantity = 1;
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    isFavorite = favorite;

    super.initState();
  }

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
            border: Border.all(
              color: Color.fromARGB(255, 66, 184, 113), // Set border color here
              width: 1.0, // Set border width here
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: MyAppColors.bgGreen,
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => {
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
                  )
                },
                child: Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.product_details.image_url),
                      fit: BoxFit.cover,
                    ),
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
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        widget.product_details.category,
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                dynamic result = CustomerService(uid: user!.uid)
                                    .removeFromCart(
                                  widget.product_details.item_name,
                                  widget.product_details.description,
                                  widget.product_details.price,
                                  widget.product_details.image_url,
                                  quantity,
                                  widget.product_details.category,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.green, // Background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  padding: EdgeInsets.all(2)),
                              child: const Text(
                                'Remove from Cart',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
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
          right: 50,
          top: 40,
          child: Text(
            '\$${widget.product_details.price * widget.product_details.stock}', // Assuming you have a price field
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
