import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Your Orders'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount:
            All_order.length, // Replace with your actual order list length
        itemBuilder: (context, index) {
          return OrderItem(orderDetail :All_order[index]);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(orderDetail.item_name), // Display product name
            subtitle: Text(
                '${orderDetail.stock} x \$${orderDetail.price}'), // Display quantity and price per quantity
            trailing: Icon(Icons.more_vert),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller: ${orderDetail.shopkeeper_uid}', // Display seller's UID
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'Order Status: ${orderDetail.status}'), // Display order status
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        // Handle contact seller action
                        Future result =  await CustomerService(uid: "").callShopkeeper(orderDetail.shopkeeper_uid);
                        
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
