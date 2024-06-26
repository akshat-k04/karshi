// import 'dart:js_interop';

// import 'package:uuid/uuid.dart';
class UserAuth{
  final String uid;
  UserAuth({required this.uid});
}

class RoleModel {
  final String role;
  RoleModel({required this.role});
}

class CustomerData {
  final String customer_name, customer_address, email;
  final int mobile_number;
  final String uid;

  CustomerData({required this.customer_name, required this.customer_address, required this.mobile_number, required this.email, required this.uid});
}


class ShopKeeperData {
  final String email, owner_name, shop_name, shop_address, latitude, longitude;
  final int mobile_number;
  final String uid;

  ShopKeeperData({required this.email, required this.owner_name, required this.shop_name, required this.shop_address, required this.mobile_number, required this.latitude, required this.longitude, required this.uid});
}

class Item {
  final String item_name, description, image_url, category;
  final int price, stock;

  Item({required this.description, required this.item_name, required this.price, required this.image_url, required this.stock, required this.category});
}

class Order_Model {
  final String customer_uid, shopkeeper_uid, item_name;
  final int stock, price;
  final String orderNumber, status;

  Order_Model({required this.customer_uid, required this.shopkeeper_uid, required this.item_name, required this.stock, required this.price, required this.orderNumber,required this.status});
}
