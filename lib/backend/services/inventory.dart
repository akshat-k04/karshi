import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karshi/backend/models/models.dart';

class InventoryService{
  final String uid;
  InventoryService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Inventory');


  // Future enteritem(String item_name, String description, int price, String image_url, int stock) async{
  //   return await userCollection.doc('new').collection(uid).doc(item_name).set({
  //     'item_name': item_name,
  //     'description': description,
  //     'price': price,
  //     'image_url': image_url,
  //     'stock': stock
  //   });
  // }

  Future updateitem(String item_name, String description, int price, String image_url, int stock) async{
    return await userCollection.doc('new').collection(uid).doc(item_name).set({
      'item_name': item_name,
      'description': description,
      'price': price,
      'image_url': image_url,
      'stock': stock
    });
  }

  List<Item> _convertitems(QuerySnapshot snapshot){
    return snapshot.docs.map((docs){
      return Item(item_name: docs['item_name'],price: docs['price'], description: docs['description'], image_url: docs['image_url'], stock: docs['stock']);
    }).toList();
  }

  Stream<List<Item>> get items{
    return userCollection.doc('new').collection(uid).snapshots().map(_convertitems);
  } 

}