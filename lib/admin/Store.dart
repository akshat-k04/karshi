import 'package:flutter/material.dart';
import 'package:karshi/admin/All_user.dart';
import 'package:karshi/app_colors.dart';
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
          product.shop_name.contains(value)) {
        Show_shop.add(product);
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
            '   Sellers',
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
                hintText: 'Search Sellers',
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
              itemCount:
                  Show_shop.length, // Assuming Show_user is a list of user data
              itemBuilder: (BuildContext context, int index) {
                return UserCard(
                  name: Show_shop[index].shop_name,
                  address: Show_shop[index].shop_address,
                  // Replace with actual address data if available
                  contact: Show_shop[index]
                      .mobile_number
                      .toString(), // Replace with actual contact data if available
                  orderStatus:
                      'Shipped', // Replace with actual order status data if available
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
