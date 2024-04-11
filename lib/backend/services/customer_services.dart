import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karshi/backend/models/models.dart';

class CustomerService {

  final String uid;
  CustomerService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Customer_Data');

  Future updateCustomerData(String email, String customer_name, String customer_address, int mobile_number) async{
    return await userCollection.doc(uid).set({
      'customer_name': customer_name,
      'customer_address': customer_address,
      'mobile_number': mobile_number,
      'email': email,
      'whishlist': [],
      'cart': []
    });
  }

  CustomerData _dataCollectionFromSnapshot(DocumentSnapshot snapshot){
    // print(snapshot['role']);
    return CustomerData(
        customer_name: snapshot['customer_name'],
        customer_address: snapshot['customer_address'],
        email: snapshot['email'],
        mobile_number: snapshot['mobile_number']
    );
  }

  Future addToCart(String item_name, String description, int price, String image_url, int stock) async{
    return await userCollection.doc(uid).update({
      'cart': FieldValue.arrayUnion([
        {
          'item_name': item_name,
          'description': description,
          'price': price,
          'image_url': image_url,
          'stock': stock,
        }
      ])
    });
  }

  Future removeFromCart(String item_name) async{
    return await userCollection.doc(uid).update({
      'cart': FieldValue.arrayRemove([
        {
          'item_name': item_name,
        }
      ])
    });
  }


  Future getCart() async{
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    List<Item> items = [];
    if (snapshot.exists) {
      List<dynamic> itemList = (snapshot.data() as Map<String, dynamic>)['cart'];
      if (itemList != null) {
        items = itemList.map((item) => Item(
          item_name: item['item_name'],
          description: item['description'],
          price: item['price'],
          image_url: item['image_url'],
          stock: item['stock'],
        )).toList();
      }
    }
    return items;
  }

  Future addToWishlist(String item_name, String description, int price, String image_url, int stock) async{
    return await userCollection.doc(uid).update({
      'wishlist': FieldValue.arrayUnion([
        {
          'item_name': item_name,
          'description': description,
          'price': price,
          'image_url': image_url,
          'stock': stock,
        }
      ])
    });
  }

  Future removeFromWishlist(String item_name) async{
    return await userCollection.doc(uid).update({
      'wishlist': FieldValue.arrayRemove([
        {
          'item_name': item_name,
        }
      ])
    });
  }

  Future getWhishlist() async{
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    List<Item> items = [];
    if (snapshot.exists) {
      List<dynamic> itemList = (snapshot.data() as Map<String, dynamic>)['whishlist'];
      if (itemList != null) {
        items = itemList.map((item) => Item(
          item_name: item['item_name'],
          description: item['description'],
          price: item['price'],
          image_url: item['image_url'],
          stock: item['stock'],
        )).toList();
      }
    }
    return items;
  }

  Future getAllItems() async {
    CollectionReference shopCollection = FirebaseFirestore.instance.collection('ShopKeeper_Data');
    QuerySnapshot snapshot = await shopCollection.get();
    List<Item> items = [];
    snapshot.docs.forEach((doc) {
      List<dynamic> itemList = doc['items'];
      itemList.forEach((item) {
      Item newItem = Item(
        description: item['description'],
        item_name: item['item_name'],
        price: item['price'],
        image_url: item['image_url'],
        stock: item['stock']
      );
      if (!items.contains(newItem)) {
        items.add(newItem);
      }
      });
    });
    return items;
  }



  Stream<CustomerData> get userInformation{
    return userCollection.doc(uid).snapshots()
        .map(_dataCollectionFromSnapshot);
  }
}
