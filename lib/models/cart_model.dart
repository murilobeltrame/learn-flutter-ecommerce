import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;
  List<CartProduct> products = [];

  CartModel(this.user);

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  addItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance.collection('users')
      .document(user.user.uid)
      .collection('cart')
      .add(cartProduct.toMap())
      .then((document) => cartProduct.id = document.documentID);
    notifyListeners();
  }

  removeItem(CartProduct cartProduct) {
    Firestore.instance.collection('users')
      .document(user.user.uid)
      .collection('cart')
      .document(cartProduct.id)
      .delete();
    products.remove(cartProduct);
    notifyListeners();
  }
}