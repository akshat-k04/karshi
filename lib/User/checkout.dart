import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/User/Product_details.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:provider/provider.dart';
// import 'package:location/location.dart';

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
  late TextEditingController _pinCode;
  late TextEditingController _state;
  late TextEditingController _town;

  CustomerData? user = null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _pinCode = TextEditingController();
    _state = TextEditingController();
    _town = TextEditingController();

    _pinCode.text = "11000";
    _state.text = "Delhi";
    _town.text = "Delhi";
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
    // late String lat;
    // late String long;

    Future<Position> _getCurrentPosition() async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    }

    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Customer Details:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .white, // Ensuring the color matches the white theme
                ),
              ),
              const SizedBox(height: 30.0),
              TextField(
                readOnly: false,
                controller: _nameController,
                style: const TextStyle(
                    color: Colors.white), // Text color in TextField
                decoration: const InputDecoration(
                  labelText: 'Customer Name',

                  labelStyle: TextStyle(
                      color: MyAppColors.textColor,
                      fontSize: 20), // Label color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyAppColors
                            .selectedGreen), // Border color when TextField is enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .white), // Border color when TextField is focused
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              TextField(
                readOnly: true,
                controller: _addressController,
                style: const TextStyle(
                    color: Colors.white), // Text color in TextField
                decoration: const InputDecoration(
                  labelText: 'Address Details',
                  labelStyle: TextStyle(
                      color: MyAppColors.textColor,
                      fontSize: 20), // Label color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyAppColors
                            .selectedGreen), // Border color when TextField is enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .white), // Border color when TextField is focused
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                readOnly: true,
                controller: _town,
                style: const TextStyle(
                    color: Colors.white), // Text color in TextField
                decoration: const InputDecoration(
                  labelText: 'Town/City/Village',
                  labelStyle: TextStyle(
                      color: MyAppColors.textColor,
                      fontSize: 20), // Label color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyAppColors
                            .selectedGreen), // Border color when TextField is enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .white), // Border color when TextField is focused
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                readOnly: true,
                controller: _state,
                style: const TextStyle(
                    color: Colors.white), // Text color in TextField
                decoration: const InputDecoration(
                  labelText: 'State',
                  labelStyle: TextStyle(
                      color: MyAppColors.textColor,
                      fontSize: 20), // Label color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyAppColors
                            .selectedGreen), // Border color when TextField is enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .white), // Border color when TextField is focused
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                readOnly: true,
                controller: _pinCode,
                style: const TextStyle(
                    color: Colors.white), // Text color in TextField
                decoration: const InputDecoration(
                  labelText: 'PinCode ',
                  labelStyle: TextStyle(
                      color: MyAppColors.textColor,
                      fontSize: 20), // Label color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyAppColors
                            .selectedGreen), // Border color when TextField is enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .white), // Border color when TextField is focused
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Products:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyAppColors
                      .textColor, // Assuming this is set to a suitable green shade
                ),
              ),
              for (int i = 0; i < widget.cartProducts.length; i++)
                ProductItem(
                    product_details: (widget.cartProducts)[i],
                    isfavorite: true),
              // ListView.builder(
              //   padding: const EdgeInsets.all(20),
              //   itemCount: widget.cartProducts.length,
              //   itemBuilder: (context, index) {
              //     return ProductItem(
              //         product_details: (widget.cartProducts)[index],
              //         isfavorite: true);
              //   },
              // ),
              const SizedBox(height: 16.0),
              Text(
                  'Grand Total:                                                   \$${widget.grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Add your logic for checkout
                  Position position = await _getCurrentPosition();
                  dynamic result = await CustomerService(uid: widget.uid)
                      .buyItems(position.latitude, position.longitude);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize
                              .min, // To make the dialog as tall as the content
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 60.0, // Icon size can be adjusted as needed
                            ),
                            const SizedBox(height: 24.0),
                            const Text(
                              'Order Confirmed',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    24.0, // Adjust the font size as needed
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              'Your order has been successfully placed',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24.0),
                            ElevatedButton(
                              onPressed: () {
                                // Logic to continue shopping
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    MyAppColors.textColor, // Background color
                                shape: const StadiumBorder(),
                              ),
                              child: const Text(
                                'Continue Shopping!',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // Close popup view after 2 seconds
                  Timer(const Duration(seconds: 2), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HomePage(uid: widget.uid),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                      (route) => false,
                    );
                  });
                  print('Place Order');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10.0)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyAppColors.bgGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Color.fromARGB(
                            255, 66, 184, 113), // Set border color here
                        width: 1.0, // Set border width here
                      ),
                    ),
                  ),
                ),
                child: const Text('Place Order',
                    style:
                        TextStyle(color: MyAppColors.textColor, fontSize: 30)),
              ),
            ],
          ),
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
              color: const Color.fromARGB(
                  255, 66, 184, 113), // Set border color here
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
                      transitionDuration: const Duration(milliseconds: 500),
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
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        widget.product_details.category,
                        style: const TextStyle(
                            fontSize: 16.0, color: MyAppColors.textColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 40,
          top: 80,
          child: Text(
            '\$${widget.product_details.price}', // Assuming you have a price field
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
