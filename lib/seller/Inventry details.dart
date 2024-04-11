import 'package:flutter/material.dart';
import 'package:karshi/app_colors.dart';

class InventoryDescriptionPage extends StatefulWidget {
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
          Image.asset(
            'assets/images/temp.png', // Replace with your image
            height: 300.0,
            fit: BoxFit.cover,
          ),
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
            onPressed: () async {},
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
              'Add Product',
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
        setState(() {
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
          }
        });
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
