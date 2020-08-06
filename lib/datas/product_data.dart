import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String categoryId;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.title = snapshot.data['title'];
    this.description = snapshot.data['description'];
    this.price = snapshot.data['price'] + 0.0;
    this.images = snapshot.data['images'];
    this.sizes = snapshot.data['sizes'];
  }
}