
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karshi/backend/models/models.dart';

class ShopKeeperService {
  final String uid;
  ShopKeeperService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('ShopKeeper_Data');

  Future updateShopKeeperData(String email, String owner_name, String shop_address, int mobile_number, String shop_name, String latitude, String longitude) async{
    return await userCollection.doc(uid).set({
      'owner_name': owner_name,
      'shop_address': shop_address,
      'mobile_number': mobile_number,
      'email': email,
      'shop_name': shop_name,
      'latitude': latitude,
      'longitude': longitude
    });
  }

  Future addItem(String item_name, String description, int price, String image_url, int stock) async{
    return await userCollection.doc(uid).update({
      'items': FieldValue.arrayUnion([
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

  Future deleteItem(String item_name) async{
    return await userCollection.doc(uid).update({
      'items': FieldValue.arrayRemove([
        {
          'item_name': item_name,
        }
      ])
    });
  }

  Future updateItem(String item_name, String description, int price, String image_url, int stock) async{
    await deleteItem(item_name);
    return await userCollection.doc(uid).update({
      'items': FieldValue.arrayUnion([
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
  Future<List<Item>> getItems() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    List<Item> items = [];
    if (snapshot.exists) {
      List<dynamic> itemList = (snapshot.data() as Map<String, dynamic>)['items'];
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

  ShopKeeperData _dataCollectionFromSnapshot(DocumentSnapshot snapshot){
    // print(snapshot['role']);
    return ShopKeeperData(
        owner_name: snapshot['owner_name'],
        shop_name: snapshot['shop_name'],
        shop_address: snapshot['shop_address'],
        latitude: snapshot['latitude'],
        longitude: snapshot['longitude'],
        email: snapshot['email'],
        mobile_number: snapshot['mobile_number']
    );
  }

  Stream<ShopKeeperData> get userInformation{
    return userCollection.doc(uid).snapshots()
        .map(_dataCollectionFromSnapshot);
  }
}