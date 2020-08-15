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

  Future<Null> _loadUser() async {
    if (user == null) user = await _auth.currentUser();
    if (user != null) {
      if (userData['name'] == null) {
        var docUser = await Firestore.instance.collection('users').document(user.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadUser();
  }

  void SignUp({
    @required Map<String, dynamic> userData,
    @required String password,
    @required VoidCallback onSuccess,
    @required VoidCallback onFailure
  }) {
    print('[DEBUG] Sign up user with ${userData['email']}');
    _notifyLoading(true);
    _auth.createUserWithEmailAndPassword(email: userData['email'], password: password)
        .then((result) async {
          user = result.user;
          await _saveUserData(userData);
          onSuccess();
          _notifyLoading(false);
        })
        .catchError((e){
          print('[DEBUG] Error signing up user');
          print(e);
          onFailure();
          _notifyLoading(false);
        });
  }

  void SignIn({
    @required String email,
    @required String password,
    @required VoidCallback onSuccess,
    @required VoidCallback onFailure
  }) async {
    print('[DEBUG] Sign in user with email $email');
    _notifyLoading(true);

    _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((result) async {
        user = result.user;
        await _loadUser();
        onSuccess();
        _notifyLoading(false);
      })
      .catchError((e){
        print('[DEBUG] Error signing in user');
        print(e);
        onFailure();
        _notifyLoading(false);
      });

    isLoading = false;
    notifyListeners();
  }

  void SignOut() async {
    print('[DEBUG] Sign out current user');
    await _auth.signOut();
    userData = null;
    user = null;
    notifyListeners();
  }

  void RecoverPass(String email){
    print('[DEBUG] Recovering password for $email');
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return user != null;
  }
}