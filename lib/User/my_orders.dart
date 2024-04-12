import 'package:flutter/material.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/admin_services.dart';
import 'package:karshi/backend/services/customer_services.dart';

class OrdersPage extends StatefulWidget {
  String uid;
  OrdersPage({required this.uid});
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order_Model> All_order = [];
  @override
  void initState() {
    // TODO: implement initState
    fetch_data();
    super.initState();
  }

  void fetch_data() async {
    All_order = await Orders_Services().getOrders();
    All_order =
        All_order.where((order) => order.customer_uid == widget.uid).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColors.backgroundColor,
        title: Text(
          'Krishi',
          style: TextStyle(
            color: MyAppColors.textColor, // Text color set to white
            fontSize: 36.0, // Choose the size that fits your design
            fontWeight: FontWeight.bold, // Text weight set to bold
          ),
        ),
      ),
      body: ListView.builder(
        itemCount:
            All_order.length, // Replace with your actual order list length
        itemBuilder: (context, index) {
          return OrderItem(orderDetail: All_order[index]);
        },
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Order_Model orderDetail; // Use your actual order model class
  // This order detail has product name, quantity, price per quantity, and order status

  OrderItem({required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color:
          MyAppColors.bgGreen, // Set the background color of the card to green
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:
              MyAppColors.selectedGreen, // Set the border color to light green
          width: 2.0, // Set the border width
        ),
        borderRadius:
            BorderRadius.circular(4.0), // Adjust the border radius if needed
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              orderDetail.item_name,
              style: TextStyle(color: Colors.white),
            ), // Display product name
            subtitle: Text(
              '${orderDetail.stock} x \$${orderDetail.price}',
              style: TextStyle(color: Colors.white),
            ), // Display quantity and price per quantity
            trailing: Icon(Icons.more_vert),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller: ${orderDetail.shopkeeper_uid}', // Display seller's UID
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text('Order Status: ${orderDetail.status}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)), // Display order status
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, // Text color
                        backgroundColor:
                            MyAppColors.greenfill, // Button background color
                      ),
                      onPressed: () async {
                        // Handle contact seller action
                        var result = await CustomerService(uid: "")
                            .callShopkeeper(orderDetail.shopkeeper_uid);
                        // Do something with the result if needed
                      },
                      child: Text('Contact Seller'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
