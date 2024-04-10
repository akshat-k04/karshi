import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karshi/backend/models/models.dart';

class ItemListService{
  final String uid;
  ItemListService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Inventory');

  Item _convert(DocumentSnapshot snapshot){
    return Item(
      item_name: snapshot['item_name'],
      description: snapshot['description'],
      price: snapshot['price'],
      image_url: snapshot['image_url'],
      stock: snapshot['stock']
    );
  }

  List<Item> _convertitems(QuerySnapshot snapshot){
    List<String> shopkeeper_uid = [];
    for (var doc in snapshot.docs){
      shopkeeper_uid.add(doc.id);
    }
    Set<Item> uniqueItems = {};

    for (var i in shopkeeper_uid){
      List<Item> temp = snapshot.docs.map((docs){
        return Item(item_name: docs['item_name'],price: docs['price'], description: docs['description'], image_url: docs['image_url'], stock: docs['stock']);
      }).toList();

      for (var item in temp) {
        uniqueItems.add(item);
      }
    }

    List<Item> uniqueItemList = uniqueItems.toList();
    // Add your logic here to convert the collection names into Item objects
    return uniqueItemList;
  }

  Stream<List<Item>> get items{
    return userCollection.snapshots().map(_convertitems);
  }
}