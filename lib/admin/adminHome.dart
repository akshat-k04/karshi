import 'package:flutter/material.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  List<String> adminData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Simulate a network call to load data with a delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy data to populate the list, replace with your actual data fetching logic
    setState(() {
      adminData = List.generate(10, (index) => 'Item $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin View'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: loadData,
          ),
        ],
      ),
      body: adminData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: adminData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(adminData[index]),
                );
              },
            ),
    );
  }
}

void main() => runApp(MaterialApp(home: AdminView()));
