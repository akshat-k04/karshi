import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karshi/backend/models/models.dart';

class Orders_Services{
  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('Orders');


  Future getOrders() async{
    QuerySnapshot snapshot = await orderCollection.get();
    List<Order_Model> orders = snapshot.docs.map((doc) => Order_Model(customer_uid: doc['customer_uid'], shopkeeper_uid: doc['shopkeeper_uid'], item_name: doc['item_name'], stock: doc['stock'], price: doc['price'])).toList();
    return orders;
  }

  Future addOrder(String customer_uid, String shopkeeper_uid, String item_name, int stock, int price) async{
    return await orderCollection.add({
      'customer_uid': customer_uid,
      'shopkeeper_uid': shopkeeper_uid,
      'item_name': item_name,
      'stock': stock,
      'price': price
    });
  } 
}