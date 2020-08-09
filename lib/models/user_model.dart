import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void _notifyLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection('users').document(user.uid).setData(userData);
  }

  void SignUp({
      @required Map<String, dynamic> userData,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFailure
    }) {
    _notifyLoading(true);
    _auth.createUserWithEmailAndPassword(email: userData['email'], password: password)
        .then((result) async {
          user = result.user;
          await _saveUserData(userData);
          onSuccess();
          _notifyLoading(false);
        })
        .catchError((e){
          onFailure();
          _notifyLoading(false);
        });
  }

  void SignIn() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  void SignOut() async {
    await _auth.signOut();
    userData = null;
    user = null;
    notifyListeners();
  }

  void RecoverPass(){

  }

  bool isLoggedIn(){
    return user != null;
  }
}