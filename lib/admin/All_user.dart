import 'package:flutter/material.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String _searchText = '';
  List<CustomerData> All_user = [];
  List<CustomerData> Show_user = [];
  @override
  void initState() {
    // TODO: implement initState
    fetch_data();
    super.initState();
  }

  void fetch_data() async {
    All_user = await CustomerService(uid: '').getAllCustomers();
    Show_user = All_user;
    setState(() {});
  }

  void filter(value) {
    for (CustomerData product in All_user) {
      if (product.customer_name.contains(value) ||
          product.customer_address.contains(value)) {
        Show_user.add(product);
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
            '   Users',
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
                hintText: 'Search Users',
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
                  Show_user.length, // Assuming Show_user is a list of user data
              itemBuilder: (BuildContext context, int index) {
                return UserCard(
                  name: Show_user[index].customer_name,
                  address: Show_user[index].customer_address,
                  // Replace with actual address data if available
                  contact: Show_user[index]
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

class UserCard extends StatelessWidget {
  final String name;
  final String address;
  final String contact;
  final String orderStatus;

  const UserCard({
    Key? key,
    required this.name,
    required this.address,
    required this.contact,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyAppColors.bgGreen, // Adjust the color to match your design
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: MyAppColors.selectedGreen,
            width: 2), // This defines the border color and width
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5, // Adjust elevation for shadow
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
            Row(
              children: [
                Icon(Icons.home, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  address,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  contact,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Latest Order Status: $orderStatus',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
