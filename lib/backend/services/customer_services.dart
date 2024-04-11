import 'dart:async';
// import 'dart:math';

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

  Future addToCart(String item_name, String description, int price, String image_url, int stock, String category) async{
    return await userCollection.doc(uid).update({
      'cart': FieldValue.arrayUnion([
        {
          'item_name': item_name,
          'description': description,
          'price': price,
          'image_url': image_url,
          'stock': stock,
          'category': category,
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
          category: item['category'],
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
          'category': 'category',
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
          category: item['category'],
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
        stock: item['stock'],
        category: item['category'],
      );
      items.add(newItem);
      });
    });
    return items;
  }

  Future buyItems() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    // List<Item> items = [];
    if (snapshot.exists) {
      List<dynamic> itemList = (snapshot.data() as Map<String, dynamic>)['cart'];
      if (itemList != null) {
        CollectionReference shopCollection = FirebaseFirestore.instance.collection('ShopKeeper_Data');
        QuerySnapshot shopSnapshot = await shopCollection.get();
        List<DocumentSnapshot> shopDocs = shopSnapshot.docs;
        itemList.forEach((item) async {
          // Random random = Random();
          if (shopDocs.isNotEmpty) {
            var shop = shopDocs.firstWhere((shop) => shop['items'].any((shopItem) => shopItem['item_name'] == item['item_name']));
            if (shop != null) {
              List<dynamic> shopItems = shop['items'];
              var shopItem = shopItems.firstWhere((shopItem) => shopItem['item_name'] == item['item_name']);
              if (shopItem != null && shopItem['stock'] > 0) {
          var temp = shopItem['stock'];
          await shopCollection.doc(shop.id).update({
            'items': FieldValue.arrayRemove([
              {
                'item_name': shopItem['item_name'],
                'description': shopItem['description'],
                'price': shopItem['price'],
                'image_url': shopItem['image_url'],
                'stock': shopItem['stock'],
                'category': shopItem['category'],
              }
            ])
          });
          await shopCollection.doc(shop.id).update({
            'items': FieldValue.arrayUnion([
              {
                'item_name': item['item_name'],
                'description': item['description'],
                'price': item['price'],
                'image_url': item['image_url'],
                'stock': temp - item['stock'],
                'category': item['category'],
              }
            ])
          });
              }
            }
          }
        });
        return await userCollection.doc(uid).update({
          'cart': FieldValue.delete()
        });
      }
      return null;
    }
  }

  Stream<CustomerData> get userInformation{
    return userCollection.doc(uid).snapshots()
        .map(_dataCollectionFromSnapshot);
  }
}
