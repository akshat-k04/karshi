import 'package:flutter/material.dart';
import 'package:karshi/app_colors.dart';

class OrdersDetailsList extends StatefulWidget {
  @override
  _OrdersDetailsListState createState() => _OrdersDetailsListState();
}

class _OrdersDetailsListState extends State<OrdersDetailsList> {
  // Utility function to create colored Icon based on the status
  Widget _statusIcon(String status) {
    Color statusColor;
    switch (status) {
      case 'Shipped':
        statusColor = Colors.green;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Delivered':
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
      body: ListView(
        children: [
          DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.black), // Header background color
            headingTextStyle:
                TextStyle(color: Colors.white), // Header text color
            dataTextStyle: TextStyle(color: Colors.grey), // Cell text color
            columns: [
              DataColumn(label: Text('Order ID')),
              DataColumn(label: Text('Product')),
              DataColumn(label: Text('Qty')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Revenue')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('#530002')),
                DataCell(Text('Product 1')),
                DataCell(Text('20')),
                DataCell(_statusIcon('Shipped')),
                DataCell(Text('10/3/24')),
                DataCell(Text('\$30')),
              ]),
              DataRow(cells: [
                DataCell(Text('#530002')),
                DataCell(Text('Product 2')),
                DataCell(Text('20')),
                DataCell(_statusIcon('Delivered')),
                DataCell(Text('10/3/24')),
                DataCell(Text('\$30')),
              ]),
              DataRow(cells: [
                DataCell(Text('#530002')),
                DataCell(Text('Product 3')),
                DataCell(Text('20')),
                DataCell(_statusIcon('Shipped')),
                DataCell(Text('10/3/24')),
                DataCell(Text('\$30')),
              ]),

              DataRow(cells: [
                DataCell(Text('#530002')),
                DataCell(Text('Product 4')),
                DataCell(Text('20')),
                DataCell(_statusIcon('Pending')),
                DataCell(Text('10/3/24')),
                DataCell(Text('\$30')),
              ]),
              // Repeat DataRow for each order, altering the details as necessary
              // ...
            ],
          ),
        ],
      ),
    );
  }
}
