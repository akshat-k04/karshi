
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