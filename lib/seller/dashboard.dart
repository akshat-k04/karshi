import 'package:flutter/material.dart';
import 'package:karshi/seller/Add%20inventry.dart';
import 'package:karshi/seller/Inventry%20details.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int completedOrders = 10;
  int pendingOrders = 5;
  int shippedOrders = 8;
  String Selected_catagory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop name Dashboard'),
        automaticallyImplyLeading: false, // Remove the back button icon
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
          
          Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddInventoryPage(),
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
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.28,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DashboardBlock(
                  title: 'Completed Orders',
                  value: '$completedOrders',
                  onTap: () {
                    // Handle tap on completed orders block
                  },
                ),
                SizedBox(width: 4),
                DashboardBlock(
                  title: 'Pending Orders',
                  value: '$pendingOrders',
                  onTap: () {
                    // Handle tap on pending orders block
                  },
                ),
                SizedBox(width: 4),
                DashboardBlock(
                  title: 'Shipped Orders',
                  value: '$shippedOrders',
                  onTap: () {
                    // Handle tap on shipped orders block
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        DropdownButton<String>(
          value: Selected_catagory, // Maintain original variable name
          icon: const Icon(Icons.arrow_drop_down), // Down arrow icon
          iconSize: 24.0, // Icon size
          elevation: 16, // Shadow effect
          // Customize the style to match your UI
          style: const TextStyle(
            color: Colors.black, // Adjust text color
            fontSize: 16.0, // Adjust font size
          ),
          underline: Container(
            height: 2.0, // Thickness of the underline
            color: Colors.grey, // Adjust underline color
          ),
          onChanged: (String? newValue) {
            setState(() {
              Selected_catagory = newValue!;
            });
          },
          items:
              <String>['All', 'One', 'Two', 'Three'] // List of dropdown options
                  .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20.0),
        InventoryListPage(),
      ]),
    );
  }
}

class DashboardBlock extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  DashboardBlock({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double blockWidth = MediaQuery.of(context).size.width * 0.29;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: blockWidth,
        height: blockWidth,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InventoryListPage extends StatefulWidget {
  @override
  _InventoryListPageState createState() => _InventoryListPageState();
}

class _InventoryListPageState extends State<InventoryListPage> {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InventryItem();
        },
      ),
    );
  }
}

class InventryItem extends StatefulWidget {
  @override
  _InventryItemState createState() => _InventryItemState();
}
class _InventryItemState extends State<InventryItem> {
  int availableStock = 100;
  int pendingOrders = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Product Name', // Replace with actual product name
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  // Add your function here
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          InventoryDescriptionPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                  print('Image clicked!');
                },
                child: Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/images/temp.png"), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoBox('Available Stock', availableStock.toString()),
              SizedBox(width: 10),
              _buildInfoBox('Pending Orders', pendingOrders.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
