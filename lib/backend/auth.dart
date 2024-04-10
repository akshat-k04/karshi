import 'package:firebase_auth/firebase_auth.dart';
// import 'database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserAuth? _userFromFirebaseUser(User? user) {
    return user != null ? UserAuth(uid: user.uid) : null;
  }

  Stream<UserAuth?> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  Future register_shopkeeper(String email, String password, String shop_name, String owner_name, int mobile_number, String shop_address, String latitude, String longitude) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if(user != null){
        // await DatabaseService(uid: user.uid).updateUserData(email, name, bhawan, room_number, enrollment_number, branch, role);
        // await DataBaseLaundry(uid: user.uid,bhawan: bhawan).updateData(name,room_number, '', false);
        // await DatabaseEntryExit(uid: user.uid,Bhawan: bhawan).statusUserEntry(bhawan, false,false);
      }
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future register_customer(String email, String password, String customer_name, int mobile_number, String customer_address) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if(user != null){
        // await DatabaseService(uid: user.uid).updateUserData(email, name, bhawan, room_number, enrollment_number, branch, role);
        // await DataBaseLaundry(uid: user.uid,bhawan: bhawan).updateData(name,room_number, '', false);
        // await DatabaseEntryExit(uid: user.uid,Bhawan: bhawan).statusUserEntry(bhawan, false,false);
      }
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  Future signIn(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}

class UserAuth{
  final String uid;
  UserAuth({required this.uid});
}

class Role {
  final String uid;
  Role({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Role_Data');

  Future update_role(String role) async{
    return await userCollection.doc(uid).set({
      'role' : role
    });
  }
}

class CustomerData {
  final String customer_name, customer_address, email;
  final int mobile_number;

  CustomerData({required this.customer_name, required this.customer_address, required this.mobile_number, required this.email});
}

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

class ShopKeeperData {
  final String email, owner_name, shop_name, shop_address, latitude, longitude;
  final int mobile_number;

  ShopKeeperData({required this.email, required this.owner_name, required this.shop_name, required this.shop_address, required this.mobile_number, required this.latitude, required this.longitude});
}

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