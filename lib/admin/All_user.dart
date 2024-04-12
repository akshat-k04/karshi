import 'package:flutter/material.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String _searchText = '';
  List<CustomerData> All_user=[];
  List<CustomerData> Show_user =[] ;
  @override
  void initState() {
    // TODO: implement initState
    fetch_data();
    super.initState();
  }

  void fetch_data()async {
    All_user = await CustomerService(uid: '').getAllCustomers() ;
    Show_user = All_user ;
    setState(() {});
  }

  void filter(value){
    for (CustomerData product in All_user) {
      if (product.customer_name.contains(value) ||
          product.customer_address.contains(value)) {
        Show_user.add(product);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged : (value)=>{
                filter(value) 
              },
              decoration: InputDecoration(
                hintText: 'Search users',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Show_user.length, // Replace with your actual user list length
              itemBuilder: (context, index) {
                // Replace this with your user list item widget
                return ListTile(
                  title: Text(Show_user[index].customer_name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
