import 'package:flutter/material.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/shopkeeper_services.dart';
import 'package:karshi/seller/dashboard.dart';

class InventoryDescriptionPage extends StatefulWidget {
  Item product_detail;
  String uid;
  List<Order_Model> All_order ;
  InventoryDescriptionPage({required this.product_detail, required this.uid,required this.All_order});

  @override
  _InventoryDescriptionPageState createState() =>
      _InventoryDescriptionPageState();
}

class _InventoryDescriptionPageState extends State<InventoryDescriptionPage> {
  String name = 'Product Name';
  String price = '100';
  String description = 'Product Description';
  String category = 'Category';
  int availableStock = 100;
  int completedOrders = 50;
  int pendingOrders = 20;
  int shippedOrders = 30;
  String url = "";
  @override
  void initState() {
    // TODO: here i need to find the pending and shipping order
    set_data();
    super.initState();
  }

  void set_data() {
    name = widget.product_detail.item_name;
    price = widget.product_detail.price.toString();
    description = widget.product_detail.description;
    category = widget.product_detail.category;
    availableStock = widget.product_detail.stock;
    url = widget.product_detail.image_url;
    completedOrders =( widget.All_order.where((order) =>order.item_name == name &&order.status == 'completed')).length ;
    pendingOrders =( widget.All_order.where((order) =>order.item_name == name &&order.status == 'pending')).length ;
    shippedOrders= (widget.All_order.where(
            (order) => order.item_name == name && order.status == 'shipped'))
        .length;
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Image(
            image: NetworkImage(url),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          // Image.asset(
          //   'assets/images/temp.png', // Replace with your image
          //   height: 300.0,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(height: 12.0),
          _buildEditableField('Name', name),
          _buildEditableField('Price', price),
          _buildEditableField('Description', description, maxLines: 3),
          _buildEditableField('Category', category),
          _buildEditableField('Available Stock', availableStock.toString()),
          _buildNonEditableField(
              'Completed Orders', completedOrders.toString()),
          _buildNonEditableField('Pending Orders', pendingOrders.toString()),
          _buildNonEditableField('Shipped Orders', shippedOrders.toString()),
          SizedBox(height: 0.0),
          ElevatedButton(
            onPressed: () async {
              dynamic result = await ShopKeeperService(uid: widget.uid)
                  .deleteItem(
                      widget.product_detail.item_name,
                      widget.product_detail.description,
                      widget.product_detail.price,
                      widget.product_detail.image_url,
                      widget.product_detail.stock,
                      widget.product_detail.category);
              result = await ShopKeeperService(uid: widget.uid).addItem(
                  name, description, int.parse(price), url, availableStock, category);

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
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  MyAppColors.bgGreen), // Background color
              foregroundColor: MaterialStateProperty.all(
                  MyAppColors.textColor), // Text color
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side:
                      BorderSide(color: MyAppColors.selectedGreen, width: 2.0),
                  borderRadius: BorderRadius.circular(10), // Corner radius
                ),
              ),
              // If you need to adjust the button's padding:
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
              // If you need to adjust the button's elevation (shadow):
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              'Update Product',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Makes the text bold
              ),
            ),
          ),
          ElevatedButton( // Delete Button
            onPressed: () async {
              dynamic result = await ShopKeeperService(uid: widget.uid)
                  .deleteItem(
                      widget.product_detail.item_name,
                      widget.product_detail.description,
                      widget.product_detail.price,
                      widget.product_detail.image_url,
                      widget.product_detail.stock,
                      widget.product_detail.category);
              // result = await ShopKeeperService(uid: widget.uid).addItem(
              //     name, description, int.parse(price), url, availableStock, category);

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
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  MyAppColors.bgGreen), // Background color
              foregroundColor: MaterialStateProperty.all(
                  MyAppColors.textColor), // Text color
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side:
                      BorderSide(color: MyAppColors.selectedGreen, width: 2.0),
                  borderRadius: BorderRadius.circular(10), // Corner radius
                ),
              ),
              // If you need to adjust the button's padding:
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
              // If you need to adjust the button's elevation (shadow):
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              'Delete Product',
              style: TextStyle(
                fontWeight: FontWeight.bold, // Makes the text bold
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, String value, {int maxLines = 1}) {
    return TextFormField(
      initialValue: value,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: MyAppColors.textColor)),
      onChanged: (newValue) {
        switch (label) {
            case 'Name':
              name = newValue;
              break;
            case 'Price':
              price = newValue;
              break;
            case 'Description':
              description = newValue;
              break;
            case 'Category':
              category = newValue;
              break;
            case 'Available Stock':
              availableStock = int.parse(newValue);
              break;
          }
        setState(() {});
      },
    );
  }

  Widget _buildNonEditableField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 20), // Add horizontal padding
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0, // Adjust the font size as needed
              // Make the label bold
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign
                  .right, // Aligns the text to the right side of the Row
              style: TextStyle(
                color: MyAppColors.textColor,
                fontSize:
                    16.0, // Ensure both label and value have the same font size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
