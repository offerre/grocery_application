import 'package:isar/isar.dart';

part 'cart_item.g.dart';

@collection
class CartItem {
  Id id = Isar.autoIncrement;
  ProductItem? productItem;
  int? quantity;
  int totalPrice = 0;
}

@embedded
class ProductItem {
  int? id;
  String? title;
  String? description;
  int? price;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;
}
