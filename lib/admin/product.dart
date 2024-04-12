import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) => {filter(value)},
              decoration: InputDecoration(
                hintText: 'Search users',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  Show_Items.length, // Replace with your actual user list length
              itemBuilder: (context, index) {
                // Replace this with your user list item widget
                return ListTile(
                  title: Text(Show_Items[index].item_name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
