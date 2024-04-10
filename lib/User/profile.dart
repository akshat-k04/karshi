import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          _buildTextField("Name", _nameController, _nameFocusNode),
          SizedBox(height: 16.0),
          _buildTextField("Address", _addressController, _addressFocusNode),
          SizedBox(height: 16.0),
          _buildTextField("Mobile Number", _mobileController, _mobileFocusNode),
          SizedBox(height: 16.0),
          _buildTextField("Email Address", _emailController, _emailFocusNode),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, FocusNode focusNode) {
    return _isEditing
        ? EditableText(
            controller: controller,
            focusNode: focusNode,
            backgroundCursorColor: Colors.blue,
            cursorColor: Colors.blue,
            style: TextStyle(fontSize: 18.0),
            cursorWidth: 2.0,
            maxLines: 1,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              // Update the controller's text
              controller.text = value;
            },
          )
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(focusNode);
            },
            child: Text(
              controller.text,
              style: TextStyle(fontSize: 18.0),
            ),
          );
  }

  @override
  void dispose() {
    // Dispose the controllers and focus nodes when the widget is disposed
    _nameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _addressFocusNode.dispose();
    _mobileFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
