import 'dart:async';
import 'dart:math';
// import 'dart:html';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:uuid/uuid.dart';
// import 'package:location/location.dart';

class CustomerService {
  final String uid;
  CustomerService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Customer_Data');

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');

  Future updateCustomerData(String email, String customer_name,
      String customer_address, int mobile_number) async {
    return await userCollection.doc(uid).set({
      'customer_name': customer_name,
      'customer_address': customer_address,
      'mobile_number': mobile_number,
      'email': email,
      'whishlist': [],
      'cart': []
    });
  }

  Future callShopkeeper(String shopkeeper_uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('ShopKeeper_Data').doc(shopkeeper_uid).get();
    // return snapshot;
    int mobile_number = snapshot['mobile_number'];

    await FlutterPhoneDirectCaller.callNumber(mobile_number.toString());
  }

  Future getUserData() async {
    // print(snapshot['role']);
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    return CustomerData(
        customer_name: snapshot['customer_name'],
        customer_address: snapshot['customer_address'],
        email: snapshot['email'],
        mobile_number: snapshot['mobile_number'],
        uid: snapshot.id);
  }

  Future<List<CustomerData>> getAllCustomers() async {
    QuerySnapshot snapshot = await userCollection.get();
    List<CustomerData> customers = [];
    snapshot.docs.forEach((doc) {
      customers.add(CustomerData(
          customer_name: doc['customer_name'],
          customer_address: doc['customer_address'],
          email: doc['email'],
          mobile_number: doc['mobile_number'],
          uid: doc.id));
    });
    return customers;
  }

  Future addToCart(String item_name, String description, int price,
      String image_url, int stock, String category) async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    if (snapshot.exists) {
      List<dynamic> cart = (snapshot.data() as Map<String, dynamic>)['cart'];
      if (cart != null) {
        var itemIndex =
            cart.indexWhere((item) => item['item_name'] == item_name);
        if (itemIndex != -1) {
          // Item exists in cart, update stock
          cart[itemIndex]['stock'] += stock;
          return await userCollection.doc(uid).update({'cart': cart});
        } else {
          // Item does not exist in cart, add it
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
      } else {
        // Cart is null, add item
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
    }
  }

  Future removeFromCart(String item_name, String description, int price,
      String image_url, int stock, String category) async {
    return await userCollection.doc(uid).update({
      'cart': FieldValue.arrayRemove([
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

  Future getCart() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    List<Item> items = [];
    if (snapshot.exists) {
      List<dynamic> itemList =
          (snapshot.data() as Map<String, dynamic>)['cart'];
      if (itemList != null) {
        items = itemList
            .map((item) => Item(
                  item_name: item['item_name'],
                  description: item['description'],
                  price: item['price'],
                  image_url: item['image_url'],
                  stock: item['stock'],
                  category: item['category'],
                ))
            .toList();
      }
    }
    return items;
  }

  Future addToWishlist(String item_name, String description, int price,
      String image_url, int stock, String category) async {
    return await userCollection.doc(uid).update({
      'wishlist': FieldValue.arrayUnion([
        {
          'item_name': item_name,
          'description': description,
          'price': price,
          'image_url': image_url,
          'stock': stock,
          'category': category
        }
      ])
    });
  }

  Future removeFromWishlist(String item_name, String description, int price,
      String image_url, int stock, String category) async {
    return await userCollection.doc(uid).update({
      'wishlist': FieldValue.arrayRemove([
        {
          'item_name': item_name,
          'description': description,
          'price': price,
          'image_url': image_url,
          'stock': stock,
          'category': category
        }
      ])
    });
  }

  Future getWishlist() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    List<Item> items = [];
    if (snapshot.exists) {
      List<dynamic>? itemList =
          (snapshot.data() as Map<String, dynamic>)['wishlist'];
      if (itemList != null) {
        items = itemList
            .map((item) => Item(
                  item_name: item['item_name'],
                  description: item['description'],
                  price: item['price'],
                  image_url: item['image_url'],
                  stock: item['stock'],
                  category: item['category'],
                ))
            .toList();
      }
    }
    return items;
  }

  Future getAllItems() async {
    CollectionReference shopCollection =
        FirebaseFirestore.instance.collection('ShopKeeper_Data');
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
        if (newItem.stock != 0) {
          if (!items.any(
              (existingItem) => existingItem.item_name == newItem.item_name)) {
            items.add(newItem);
          }
        }
      });
    });
    return items;
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    // Calculate the distance between two coordinates
    double earthRadius = 6371; // Radius of the earth in kilometers

    double degreesToRadians(double degrees) {
      return degrees * (pi / 180);
    }

    double lat1Radians = degreesToRadians(lat1);
    double lon1Radians = degreesToRadians(lon1);
    double lat2Radians = degreesToRadians(lat2);
    double lon2Radians = degreesToRadians(lon2);

    double dLat = lat2Radians - lat1Radians;
    double dLon = lon2Radians - lon1Radians;

    double a = pow(sin(dLat / 2), 2) +
        cos(lat1Radians) * cos(lat2Radians) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

  Future buyItems(double latitude, double longitude) async {
    print(latitude);
    print(longitude);
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    if (snapshot.exists) {
      List<dynamic> itemList =
          (snapshot.data() as Map<String, dynamic>)['cart'];
      if (itemList != null) {
        CollectionReference shopCollection =
            FirebaseFirestore.instance.collection('ShopKeeper_Data');
        QuerySnapshot shopSnapshot = await shopCollection.get();
        List<DocumentSnapshot> shopDocs = shopSnapshot.docs;
        itemList.forEach((item) async {
          // Random random = Random();
          // print(item['item_name']);
          if (shopDocs.isNotEmpty) {
            var nearestShop;
            double minDistance = double.infinity;
            shopDocs.forEach((shop) {
              List<dynamic> shopItems = shop['items'];
              // print(shopItems);
              bool found = false;
              shopItems.forEach((element) {
                if (element['item_name'] == item['item_name'] &&
                    element['stock'] - item['stock'] >= 0) {
                  found = true;
                }
              });
              if (!found) {
                return;
              }

                double shopLatitude = double.parse(shop['latitude'].toString());
                double shopLongitude = double.parse(shop['longitude'].toString());

              double distance = _calculateDistance(
                  latitude, longitude, shopLatitude, shopLongitude);
              if (distance < minDistance) {
                minDistance = distance;
                nearestShop = shop;
              }
              // }
            });
            if (nearestShop == null) {
              // Perform the necessary operations with the nearest shop
            }
            // print(shop);

            if (nearestShop != null) {
              print(nearestShop.id);
              List<dynamic> shopItems = nearestShop['items'];
              var shopItem = shopItems.firstWhere(
                  (shopItem) => shopItem['item_name'] == item['item_name']);
              if (shopItem != null && shopItem['stock'] - item['stock'] >= 0) {
                var temp = shopItem['stock'];
                await shopCollection.doc(nearestShop.id).update({
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
                await shopCollection.doc(nearestShop.id).update({
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
                await orderCollection.doc(Uuid().v4()).set({
                  'customer_uid': uid,
                  'shopkeeper_uid': nearestShop.id,
                  'item_name': item['item_name'],
                  'stock': item['stock'],
                  'price': item['price'],
                  'status': 'pending'
                });
                await removeFromCart(
                    item['item_name'],
                    item['description'],
                    item['price'],
                    item['image_url'],
                    item['stock'],
                    item['category']);
              }
            }
          }
        });
        // return await userCollection
        //     .doc(uid)
        //     .update({'cart': FieldValue.delete()});
      }
      return null;
    }
  }

}
