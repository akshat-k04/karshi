// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:karshi/Admin/All_user.dart';
import 'package:karshi/Admin/Store.dart';
import 'package:karshi/admin/adminHome.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/admin_services.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
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
      body: CustomMaterialIndicator(
        onRefresh: () async {
          fetch_data();
          // return null;
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return Icon(
            Icons.ac_unit,
            color: Colors.blue,
            size: 30,
          );
        },
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) => {filter_product_func(value)},
                decoration: InputDecoration(
                  hintText: 'Search by Products',
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
            // User, Store, Product icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UserListPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                      (route) => false,
                    )
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  UserListPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: IconCard(
                      icon: Icons.person,
                      iconColor: Colors.white,
                      label: 'User',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            StoreListPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: IconCard(
                    icon: Icons.store,
                    label: 'Store',
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            StoreListPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    )
                  },
                  child: IconCard(
                    icon: Icons.shopping_bag,
                    label: 'Product',
                  ),
                ),
              ],
            ),
            // Pie chart
            PieChartWidget(),
            // Order list
            OrderList(All_order: All_orders),
          ],
        ),
      ),
    );
  }

  filter_product_func(String value) {}
}

class IconCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor; // Add this line

  const IconCard({
    Key? key,
    required this.icon,
    required this.label,
    this.iconColor = Colors.white, // Default color is white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          padding: EdgeInsets.all(8), // Padding inside the container
          decoration: BoxDecoration(
            color: Colors.transparent, // Background color of the container
            border: Border.all(
              color: MyAppColors.selectedGreen, // Color of the border
              width: 3, // Thickness of the border
            ),
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 80,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 40,
        )
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
          PieChartSectionData(color: Colors.red, value: 4, title: '4'),
          PieChartSectionData(
            color: Colors.yellow,
            value: 2,
            title: '2',
          ),
          PieChartSectionData(
            color: Colors.green,
            value: 2,
            title: '2',
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
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        // Replace this with your order list widget
        // Example order list item

        DataTable(
          columnSpacing: 16, // Adjust the spacing between columns
          headingRowHeight: 40, // Set the height of the heading row
          dataRowHeight: 60, // Set the height of data rows
          columns: [
            DataColumn(
                label: Text(
              'Order ID',
              style: TextStyle(color: MyAppColors.textColor),
            )),
            DataColumn(
                label: Text('Product',
                    style: TextStyle(color: MyAppColors.textColor))),
            DataColumn(
                label: Text('Qty',
                    style: TextStyle(color: MyAppColors.textColor))),
            DataColumn(
                label: Text('Status',
                    style: TextStyle(color: MyAppColors.textColor))),
            DataColumn(
                label: Text('Date',
                    style: TextStyle(color: MyAppColors.textColor))),
            DataColumn(
                label: Icon(Icons.more_vert,
                    color:
                        MyAppColors.textColor)), // Placeholder for action icon
          ],
          rows: List<DataRow>.generate(
            All_order.length,
            (index) => DataRow(
              cells: [
                DataCell(Text(
                  All_order[index].orderNumber.substring(0, 8),
                  style: TextStyle(color: Colors.white),
                )),
                DataCell(Text(All_order[index].item_name,
                    style: TextStyle(color: Colors.white))),
                DataCell(Text(All_order[index].stock.toString(),
                    style: TextStyle(color: Colors.white))),
                DataCell(Row(
                  children: [
                    Icon(Icons.circle,
                        color: All_order[index].status == 'completed'
                            ? Colors.green
                            : All_order[index].status == 'shipped'
                                ? Colors.yellow
                                : Colors.red),
                    SizedBox(width: 5),
                    Text(All_order[index].status,
                        style: TextStyle(color: Colors.white)),
                  ],
                )),
                DataCell(
                  Text(
                    '12/4/2024',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataCell(Icon(
                  Icons.more_vert,
                  color: Colors.white,
                )), // Placeholder for action icon
              ],
            ),
          ),
        ),
        // Add more list items as needed
      ],
    );
  }
}
