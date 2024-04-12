import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:karshi/User/Home_page.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
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
    late String lat;
    late String long;

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
            Text(
              'Customer Details:',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color:
                    Colors.white, // Ensuring the color matches the white theme
              ),
            ),
            SizedBox(height: 30.0),
            TextField(
              readOnly: false,
              controller: _nameController,
              style: TextStyle(color: Colors.white), // Text color in TextField
              decoration: InputDecoration(
                labelText: 'Customer Name',

                labelStyle: TextStyle(
                    color: MyAppColors.textColor, fontSize: 20), // Label color
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
            SizedBox(height: 30.0),
            TextField(
              readOnly: true,
              controller: _addressController,
              style: TextStyle(color: Colors.white), // Text color in TextField
              decoration: InputDecoration(
                labelText: 'Address Details',
                labelStyle: TextStyle(
                    color: MyAppColors.textColor, fontSize: 20), // Label color
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
            SizedBox(height: 16.0),
            TextField(
              readOnly: true,
              controller: _addressController,
              style: TextStyle(color: Colors.white), // Text color in TextField
              decoration: InputDecoration(
                labelText: 'Town/City/Village',
                labelStyle: TextStyle(
                    color: MyAppColors.textColor, fontSize: 20), // Label color
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
            SizedBox(height: 16.0),
            TextField(
              readOnly: true,
              controller: _addressController,
              style: TextStyle(color: Colors.white), // Text color in TextField
              decoration: InputDecoration(
                labelText: 'State',
                labelStyle: TextStyle(
                    color: MyAppColors.textColor, fontSize: 20), // Label color
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
            SizedBox(height: 16.0),
            TextField(
              readOnly: true,
              controller: _addressController,
              style: TextStyle(color: Colors.white), // Text color in TextField
              decoration: InputDecoration(
                labelText: 'PinCode ',
                labelStyle: TextStyle(
                    color: MyAppColors.textColor, fontSize: 20), // Label color
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
            SizedBox(
              height: 20,
            ),
            Text(
              'Products:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyAppColors
                    .textColor, // Assuming this is set to a suitable green shade
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                      product_details: (widget.cartProducts)[index],
                      isfavorite: true);
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
                'Grand Total:                                                   \$${widget.grandTotal.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Add your logic for checkout
                _getCurrentPosition().then((value) {
                  lat = '${value.latitude}';
                  long = '${value.longitude}';
                  print('Latitude: $lat, Longitude: $long');
                });
                dynamic result =
                    await CustomerService(uid: widget.uid).buyItems();
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
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 60.0, // Icon size can be adjusted as needed
                          ),
                          SizedBox(height: 24.0),
                          Text(
                            'Order Confirmed',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0, // Adjust the font size as needed
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Your order has been successfully placed',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.0),
                          ElevatedButton(
                            onPressed: () {
                              // Logic to continue shopping
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  MyAppColors.textColor, // Background color
                              shape: StadiumBorder(),
                            ),
                            child: Text(
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
                Timer(Duration(seconds: 2), () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
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
              child: Text('Place Order',
                  style: TextStyle(color: MyAppColors.textColor, fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}
