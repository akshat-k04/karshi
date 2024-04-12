import 'package:flutter/material.dart';
import 'package:karshi/app_colors.dart';
import 'package:karshi/auth%20files/signin.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/auth.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  String uid;
  ProfilePage({required this.uid});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CustomerData? user = null;
  void initState() {
    super.initState();
    fetchData();
    // () async =>
    //     {cart_product = await CustomerService(uid: widget.uid).getCart()};
    // calculateGrandTotal();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  final AuthService _auth = AuthService();

  void fetchData() async {
    user = await CustomerService(uid: widget.uid).getUserData();
    _nameController.text = user!.customer_name;
    _addressController.text = user!.customer_address;
    _mobileController.text = user!.mobile_number.toString();
    // print(user.mobile_number);
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserAuth?>(context);

    return Scaffold(
      backgroundColor: MyAppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColors.backgroundColor,
        title: Text(
          'Krashi',
          style: TextStyle(
            color: MyAppColors.textColor, // Text color set to white
            fontSize: 36.0, // Choose the size that fits your design
            fontWeight: FontWeight.bold, // Text weight set to bold
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Profile",
              style: TextStyle(
                color: Colors
                    .white, // Ensure this is visible against your app's theme
                fontWeight: FontWeight.bold,
                fontSize: 30, // Adjusted for better visual balance
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildTextField("Name", _nameController, true),
          SizedBox(height: 16.0),
          _buildTextField("Address", _addressController, true),
          SizedBox(height: 16.0),
          _buildTextField("Mobile Number", _mobileController, true),
          SizedBox(height: 16.0),
          _buildTextField("Email",
              TextEditingController(text: "example@example.com"), false),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              // Handle update profile logic
              dynamic result = CustomerService(uid: widget.uid)
                  .updateCustomerData(
                      user!.email,
                      _nameController.text,
                      _addressController.text,
                      int.parse(_mobileController.text));
              print('Profile updated');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  MyAppColors.bgGreen), // Background color
              foregroundColor: MaterialStateProperty.all(
                  MyAppColors.textColor), // Text color
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side:
                      BorderSide(color: MyAppColors.selectedGreen, width: 2.0),
                  borderRadius: BorderRadius.circular(10), // Corner radius
                ),
              ),
              // If you need to adjust the button's padding:
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
              // If you need to adjust the button's elevation (shadow):
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text('Update Profile'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              // Handle update profile logic
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

              print('Profile updated');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  MyAppColors.bgGreen), // Background color
              foregroundColor: MaterialStateProperty.all(
                  MyAppColors.textColor), // Text color
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side:
                      BorderSide(color: MyAppColors.selectedGreen, width: 2.0),
                  borderRadius: BorderRadius.circular(10), // Corner radius
                ),
              ),
              // If you need to adjust the button's padding:
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
              // If you need to adjust the button's elevation (shadow):
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text('Sign out'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool editable) {
    return TextField(
      controller: controller,
      enabled: editable,
      style: TextStyle(
        fontSize: 20,

        color: Colors.white, // Ensuring the color matches the white theme
      ),
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
              color: MyAppColors.textColor, fontSize: 20), // Label color
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyAppColors.selectedGreen),
          )),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}
