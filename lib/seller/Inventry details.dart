import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('Inventory Description'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Image.asset(
            'assets/images/temp.png', // Replace with your image
            height: 200.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          _buildEditableField('Name', name),
          _buildEditableField('Price', price),
          _buildEditableField('Description', description, maxLines: 3),
          _buildEditableField('Category', category),
          _buildEditableField('Available Stock', availableStock.toString()),
          _buildNonEditableField(
              'Completed Orders', completedOrders.toString()),
          _buildNonEditableField('Pending Orders', pendingOrders.toString()),
          _buildNonEditableField('Shipped Orders', shippedOrders.toString()),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Handle update details button
            },
            child: Text('Update Details'),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, String value, {int maxLines = 1}) {
    return TextFormField(
      initialValue: value,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
      ),
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
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}

