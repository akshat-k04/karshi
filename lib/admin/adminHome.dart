import 'package:flutter/material.dart';

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

class AdminDashboard extends StatelessWidget {
  // Placeholder data
  final int completedOrders = 20;
  final int pendingOrders = 5;
  final int shippedOrders = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Krishi App'),
        backgroundColor: Color(0xFF004D40),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.28,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DashboardBlock(
                title: 'User',
                value: '25', // Replace with actual data
                onTap: () {
                  // Handle tap
                },
              ),
              DashboardBlock(
                title: 'Store',
                value: '8', // Replace with actual data
                onTap: () {
                  // Handle tap
                },
              ),
              DashboardBlock(
                title: 'Product',
                value: '50+', // Replace with actual data
                onTap: () {
                  // Handle tap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
