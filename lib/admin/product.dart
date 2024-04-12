import 'package:flutter/material.dart';
import 'package:karshi/admin/All_user.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:karshi/backend/services/shopkeeper_services.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String _searchText = '';
  List<Item> All_Items = [];
  List<Item> Show_Items = [];
  @override
  void initState() {
    // TODO: implement initState
    fetch_data();
    super.initState();
  }

  void fetch_data() async {
    All_Items = await CustomerService(uid: '').getAllItems();
    Show_Items = All_Items;
    setState(() {});
  }

  void filter(value) {
    for (Item product in All_Items) {
      if (product.item_name.contains(value) ||
          product.description.contains(value) ||
          product.category.contains(value)) {
        Show_Items.add(product);
      }
    }
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
            fontWeight: FontWeight.bold,
            // Text weight set to bold
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back button icon
        backgroundColor: MyAppColors.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            '   Products',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) => {filter_product_func(value)},
              decoration: InputDecoration(
                hintText: 'Search Products',
                hintStyle: TextStyle(color: Colors.white),
                prefixStyle: TextStyle(color: MyAppColors.textColor),
                prefixIconColor: Colors.green,
                prefixIcon: const Icon(
                  Icons.search,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Show_Items
                  .length, // Assuming Show_user is a list of user data
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  name: Show_Items[index].item_name,
                  description: Show_Items[index].description,
                  // Replace with actual address data if available
                  // Replace with actual contact data if available
                  category: Show_Items[index]
                      .category, // Replace with actual order status data if available
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  filter_product_func(String value) {}
}

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String category;

  const ProductCard({
    Key? key,
    required this.name,
    required this.description,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyAppColors.bgGreen, // Use your custom green background color
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:
              MyAppColors.selectedGreen, // Use your custom green border color
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      elevation: 5, // Elevation for a subtle shadow
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Description',
                style: TextStyle(color: MyAppColors.textColor, fontSize: 15)),
            Text(
              description,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text('Category',
                style: TextStyle(color: MyAppColors.textColor, fontSize: 15)),
            Text(
              category,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
