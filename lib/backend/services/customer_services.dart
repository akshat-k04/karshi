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
      'email': email
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

  Stream<CustomerData> get userInformation{
    return userCollection.doc(uid).snapshots()
        .map(_dataCollectionFromSnapshot);
  }
}
