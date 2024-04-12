import 'package:flutter/material.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:karshi/backend/services/shopkeeper_services.dart';

class StoreListPage extends StatefulWidget {
  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  String _searchText = '';
  List<ShopKeeperData> All_shop = [];
  List<ShopKeeperData> Show_shop = [];
  @override
  void initState() {
    // TODO: implement initState
    fetch_data();
    super.initState();
  }

  void fetch_data() async {
    All_shop = await ShopKeeperService(uid: '').getallShopKeepers();
    Show_shop = All_shop;
    setState(() {});
  }

  void filter(value) {
    for (ShopKeeperData product in All_shop) {
      if (product.owner_name.contains(value) ||
          product.shop_address.contains(value) ||
          product.shop_name .contains(value)) {
        Show_shop.add(product);
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
                  Show_shop.length, // Replace with your actual user list length
              itemBuilder: (context, index) {
                // Replace this with your user list item widget
                return ListTile(
                  title: Text(Show_shop[index].shop_name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
