import 'package:flutter/material.dart';

class OrdersDetailsList extends StatefulWidget {
  @override
  _OrdersDetailsListState createState() => _OrdersDetailsListState();
}

class _OrdersDetailsListState extends State<OrdersDetailsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details List'),
      ),
      body: ListView(
        children: [
          DataTable(
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
                DataCell(Text('Product 2')),
                DataCell(Text('20')),
                DataCell(Row(
                  children: [
                    Icon(Icons.circle, color: Colors.green),
                    SizedBox(width: 5),
                    Text('Pending'),
                  ],
                )),
                DataCell(Text('10/3/24')),
                DataCell(Text('\$400')),
              ]),
              // Add more DataRow widgets for additional orders
            ],
          ),
        ],
      ),
    );
  }
}


