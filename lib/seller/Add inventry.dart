import 'package:flutter/material.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/shopkeeper_services.dart';
import 'package:karshi/seller/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:karshi/app_colors.dart';

class AddInventoryPage extends StatefulWidget {
  final String uid;
  AddInventoryPage({required this.uid});
  @override
  _AddInventoryPageState createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl = '';
  String productName = '';
  int price = 0;
  String description = '';
  String category = '';
  int availableStock = 0;
  List<Item> products = [];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    return
        // PopScope(
        // onPopInvoked: (didPop) {
        //   setState(()async {
        //     products = await ShopKeeperService(uid: user!.uid).getItems();
        //   });
        //   Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //       transitionDuration: Duration(milliseconds: 500),
        //       pageBuilder: (context, animation, secondaryAnimation) =>
        //           Dashboard(products: products),
        //       transitionsBuilder:
        //           (context, animation, secondaryAnimation, child) {
        //         return FadeTransition(
        //           opacity: animation,
        //           child: child,
        //         );
        //       },
        //     ),
        //   );
        // },
        // child:
        Scaffold(
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Product Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Image URL',
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the image URL';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    imageUrl = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productName = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    price = int.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    category = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Available Stock',
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the available stock';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    availableStock = int.parse(value!);
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Add your logic to save the form data
                      dynamic result = await ShopKeeperService(uid: user!.uid)
                          .addItem(productName, description, price, imageUrl,
                              availableStock, category);
                      print('Form submitted');

                      _formKey.currentState!.reset();
                      setState(() {
                        imageUrl = '';
                        productName = '';
                        price = 0;
                        description = '';
                        category = '';
                        availableStock = 0;
                      });

                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Dashboard(uid: widget.uid),
                          transitionsBuilder: (context, animation,
                              secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                        (route) => false,
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        MyAppColors.bgGreen), // Background color
                    foregroundColor: MaterialStateProperty.all(
                        MyAppColors.textColor), // Text color
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                            color: MyAppColors.selectedGreen, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(10), // Corner radius
                      ),
                    ),
                    // If you need to adjust the button's padding:
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
                    // If you need to adjust the button's elevation (shadow):
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Makes the text bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
