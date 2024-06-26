import 'package:flutter/material.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';

class OrdersDetailsList extends StatefulWidget {
  final List<Order_Model> Order_list;

  OrdersDetailsList({required this.Order_list});

  @override
  _OrdersDetailsListState createState() => _OrdersDetailsListState();
}

class _OrdersDetailsListState extends State<OrdersDetailsList> {
  // Utility function to create colored Icon based on the status
  Widget _statusIcon(String status) {
    Color statusColor;
    switch (status) {
      case 'shipped':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'completed':
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.grey;
    }
    return Row(
      children: [
        Icon(Icons.circle, color: statusColor, size: 14), // Smaller icon
        SizedBox(width: 5),
        Text(status),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Order Details List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            MyAppColors.backgroundColor, // Set the AppBar color to black
      ),
      body: SingleChildScrollView(
        physics:
            ClampingScrollPhysics(), // Add this to keep the scroll view's physics consistent with the platform
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            headingTextStyle: TextStyle(color: Colors.white),
            dataTextStyle: TextStyle(color: Colors.grey),
            columns: const [
              DataColumn(label: Text('Order ID')),
              DataColumn(label: Text('Product')),
              DataColumn(label: Text('Qty')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Revenue')),
            ],
            rows: widget.Order_list.map<DataRow>((order) {
              return DataRow(cells: [
                DataCell(Text("${order.orderNumber.substring(0, 8)}...")),
                DataCell(Text(order.item_name)),
                DataCell(Text(
                    '12/04/2024')), // Assuming this is a placeholder for the actual date
                DataCell(Text(order.stock.toString())),
                DataCell(_statusIcon(order.status)),
                DataCell(Text(
                    '\$${(order.price * order.stock).toStringAsFixed(2)}')), // Assuming price is a double
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
