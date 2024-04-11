import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karshi/backend/models/models.dart';
import 'package:karshi/backend/services/customer_services.dart';
import 'package:karshi/backend/services/shopkeeper_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserAuth? _userFromFirebaseUser(User? user) {
    return user != null ? UserAuth(uid: user.uid) : null;
  }

  Stream<UserAuth?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future register_shopkeeper(
      String email,
      String password,
      String shop_name,
      String owner_name,
      int mobile_number,
      String shop_address,
      String latitude,
      String longitude) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await Role(uid: user.uid).update_role('ShopKeeper');
        await ShopKeeperService(uid: user.uid).updateShopKeeperData(
            email,
            owner_name,
            shop_address,
            mobile_number,
            shop_name,
            latitude,
            longitude);
        // await DataBaseLaundry(uid: user.uid,bhawan: bhawan).updateData(name,room_number, '', false);
        // await DatabaseEntryExit(uid: user.uid,Bhawan: bhawan).statusUserEntry(bhawan, false,false);
      }
      UserAuth user_shopkeeper = UserAuth(uid: user!.uid);
      return user_shopkeeper;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register_customer(String email, String password, String customer_name,
      int mobile_number, String customer_address) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await Role(uid: user.uid).update_role('Customer');
        await CustomerService(uid: user.uid).updateCustomerData(
            email, customer_name, customer_address, mobile_number);
        // await DataBaseLaundry(uid: user.uid,bhawan: bhawan).updateData(name,room_number, '', false);
        // await DatabaseEntryExit(uid: user.uid,Bhawan: bhawan).statusUserEntry(bhawan, false,false);
      }
      UserAuth user_customer = UserAuth(uid: user!.uid);
      return user_customer;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        UserAuth user_obj = UserAuth(uid: user.uid);
        return user_obj;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class Role {
  final String uid;
  Role({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Role_Data');

  Future update_role(String role) async {
    return await userCollection.doc(uid).set({'role': role});
  }

  RoleModel _convert(DocumentSnapshot snapshot) {
    return RoleModel(role: snapshot['role']);
  }

  Future<RoleModel?> getRole() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    if (snapshot.exists) {
      return _convert(snapshot);
    } else {
      return null;
    }
  }
}
