import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karshi/User/Cart.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/auth%20files/signin.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/auth.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:karshi/backend/services/shopkeeper_services.dart';
import 'package:karshi/main.dart';
import 'package:karshi/seller/Add%20inventry.dart';
import 'package:karshi/seller/Inventry%20details.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  // final List<Item> products;
  // Dashboard({super.key, required this.products});

  final String uid;
  Dashboard({required this.uid});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int completedOrders = 10;
  int pendingOrders = 5;
  int shippedOrders = 8;
  String Selected_catagory = "All";
  final AuthService _auth = AuthService();
  List<Item> showproduct = [];
  @override
  void initState() {
    // TODO: implement initState
    // showproduct = widget.products;
    fetchData();
    super.initState();
  }

  void fetchData() async {
    showproduct = await ShopKeeperService(uid: widget.uid).getItems();
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
            fontWeight: FontWeight.bold, // Text weight set to bold
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async{
              // Add sign-out logic here
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SigninScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
                (route) => false,
              );
              print('Sign out');
            },
          ),
        ],
        automaticallyImplyLeading: false, // Remove the back button icon
        backgroundColor: MyAppColors.backgroundColor,
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
        SizedBox(height: 40),
        Text(
          "Shopkeeper Dashboard",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by Products',
              hintStyle: TextStyle(color: Colors.white),
              prefixStyle: TextStyle(color: MyAppColors.textColor),
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
        SizedBox(height: 30),
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
        const SizedBox(height: 20.0),
        InventoryListPage(showproduct: showproduct),
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InventoryDescriptionPage()),
        );
      },
      child: Container(
        width: blockWidth,
        height: blockWidth,
        decoration: BoxDecoration(
          color: MyAppColors.bgGreen,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                  color: MyAppColors.textColor,
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
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
  final List<Item> showproduct;
  InventoryListPage({required this.showproduct});
  @override
  _InventoryListPageState createState() => _InventoryListPageState();
}

class _InventoryListPageState extends State<InventoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.showproduct.length,
        itemBuilder: (context, index) {
          return InventryItem(product_details: (widget.showproduct)[index]);
        },
      ),
    );
  }
}

class InventryItem extends StatefulWidget {
  Item product_details;
  InventryItem({required this.product_details});

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
        color: MyAppColors.bgGreen,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image on the left

          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 13,
            ),
            Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(widget.product_details.image_url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
          SizedBox(width: 40.0),
          // Column on the right
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  widget.product_details.item_name,
                  style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10.0),
                // Available Stock
                _buildInfoBox(
                    'Available Stock', widget.product_details.stock.toString()),
                const SizedBox(height: 10.0),
                // Pending Orders
                _buildInfoBox('Pending Orders', pendingOrders.toString()),
                // const SizedBox(height: 10.0),
                // Buttons
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
