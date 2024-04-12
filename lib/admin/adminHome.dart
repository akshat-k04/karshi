// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:karshi/admin/adminHome.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/admin_services.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}


class DashboardBlock extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  DashboardBlock(
      {required this.title, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF00796B), // Custom card color
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminViewState extends State<AdminView> {
  List<Order_Model> All_orders = [];
  @override
  void initState() {
    // TODO: implement initState
    fetch_data();
    super.initState();
  }

  void fetch_data() async {
    All_orders = await Orders_Services().getOrders();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey[300],
            child: TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Search Order ID',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // User, Store, Product icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconCard(icon: Icons.person, label: 'User'),
              IconCard(icon: Icons.store, label: 'Store'),
              IconCard(icon: Icons.shopping_bag, label: 'Product'),
            ],
          ),
          // Pie chart
          PieChartWidget(),
          // Order list
          OrderList(All_order: All_orders),
        ],
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final IconData icon;
  final String label;

  IconCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 50),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PieChart(PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.blue,
            value: 30,
            title: '30%',
          ),
          PieChartSectionData(
            color: Colors.orange,
            value: 70,
            title: '70%',
          ),
        ],
      )),
    );
  }
}

class OrderList extends StatelessWidget {
  List<Order_Model> All_order;
  OrderList({required this.All_order});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Order List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Replace this with your order list widget
        // Example order list item
        
          DataTable(
          columnSpacing: 16, // Adjust the spacing between columns
          headingRowHeight: 40, // Set the height of the heading row
          dataRowHeight: 60, // Set the height of data rows
          columns: [
            DataColumn(label: Text('Order ID')),
            DataColumn(label: Text('Product')),
            DataColumn(label: Text('Qty')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Date')),
            DataColumn(
                label: Icon(Icons.more_vert)), // Placeholder for action icon
          ],
          rows: List<DataRow>.generate(
            All_order.length,
            (index) => DataRow(
              cells: [
                DataCell(Text(All_order[index].orderNumber.substring(0, 8))),
                DataCell(Text(All_order[index].item_name)),
                DataCell(Text(All_order[index].stock.toString())),
                DataCell(Row(
                  children: [
                    Icon(Icons.circle,
                        color: All_order[index].status == 'completed'
                            ? Colors.green
                            :
                            All_order[index].status == 'shipped'?Colors.yellow: Colors.red),
                    SizedBox(width: 5),
                    Text(All_order[index].status),
                  ],
                )),
                DataCell(Text('12/4/2024')),
                DataCell(Icon(Icons.more_vert)), // Placeholder for action icon
              ],
            ),
          ),
        ),
        // Add more list items as needed
      ],
    );
  }
}
