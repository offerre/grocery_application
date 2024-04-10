import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

Future<void> openIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [PlanSchema, CartItemSchema],
    directory: dir.path,
  );
}
