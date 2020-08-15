import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {
  String id;
  String categoryId;
  String productId;
  int quantity;
  String size;

  ProductData productData;

  CartProduct(this.id, this.categoryId, this.quantity, this.size);

  CartProduct.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    categoryId = snapshot.data['categoryId'];
    productId = snapshot.data['productId'];
    quantity = snapshot.data['quantity'];
    size = snapshot.data['size'];
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'productId': productId,
      'quantity': quantity,
      'size': size,
      'product': productData.toResumeMap()
    };
  }
}