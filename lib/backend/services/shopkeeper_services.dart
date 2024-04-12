// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:karshi/backend/models/models.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';

class ShopKeeperService {
  final String uid;
  ShopKeeperService({required this.uid});

  // late String lat;
  //   late String long;

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('ShopKeeper_Data');

  Future updateShopKeeperData(
      String email,
      String owner_name,
      String shop_address,
      int mobile_number,
      String shop_name,) async {

    Position position = await _getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    
    return await userCollection.doc(uid).set({
      'owner_name': owner_name,
      'shop_address': shop_address,
      'mobile_number': mobile_number,
      'email': email,
      'shop_name': shop_name,
      'latitude': latitude,
      'longitude': longitude,
      'items': []
    });
  }

  Future addItem(String item_name, String description, int price,
      String image_url, int stock, String category) async {
    return await userCollection.doc(uid).update({
      'items': FieldValue.arrayUnion([
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

  Future deleteItem(String item_name, String description, int price,
      String image_url, int stock, String category) async {
    return await userCollection.doc(uid).update({
      'items': FieldValue.arrayRemove([
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

  // Future updateItem(String item_name, String description, int price,
  //     String image_url, int stock) async {
  //   await deleteItem(item_name);
  //   return await userCollection.doc(uid).update({
  //     'items': FieldValue.arrayUnion([
  //       {
  //         'item_name': item_name,
  //         'description': description,
  //         'price': price,
  //         'image_url': image_url,
  //         'stock': stock,
  //       }
  //     ])
  //   });
  // }

  Future<List<ShopKeeperData>> getallShopKeepers() async {
    QuerySnapshot snapshot = await userCollection.get();
    List<ShopKeeperData> shopkeepers = [];
    snapshot.docs.forEach((doc) {
      shopkeepers.add(ShopKeeperData(
          owner_name: doc['owner_name'],
          shop_name: doc['shop_name'],
          shop_address: doc['shop_address'],
          latitude: doc['latitude'].toString(),
          longitude: doc['longitude'].toString(),
          email: doc['email'],
          mobile_number: doc['mobile_number'],
          uid: doc.id));
    });
    return shopkeepers;
  }

  Future<List<Item>> getItems() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    List<Item> items = [];
    if (snapshot.exists) {
      List<dynamic> itemList =
          (snapshot.data() as Map<String, dynamic>)['items'];
      print(itemList);
      if (itemList != null) {
        items = itemList
            .map((item) => Item(
                item_name: item['item_name'],
                description: item['description'],
                price: item['price'],
                image_url: item['image_url'],
                stock: item['stock'],
                category: item['category']))
            .toList();
      }
    }
    return items;
  }

  ShopKeeperData _dataCollectionFromSnapshot(DocumentSnapshot snapshot) {
    // print(snapshot['role']);
    return ShopKeeperData(
        owner_name: snapshot['owner_name'],
        shop_name: snapshot['shop_name'],
        shop_address: snapshot['shop_address'],
        latitude: snapshot['latitude'],
        longitude: snapshot['longitude'],
        email: snapshot['email'],
        mobile_number: snapshot['mobile_number'],
        uid: snapshot.id);
  }

  Stream<ShopKeeperData> get userInformation {
    return userCollection.doc(uid).snapshots().map(_dataCollectionFromSnapshot);
  }
}
