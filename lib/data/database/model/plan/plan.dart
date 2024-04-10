import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:isar/isar.dart';

part 'plan.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;
  bool isPurchased = false;
  String titlePlan = '-';
  String? notePlan;
  int totalPlanPrice = 0;
  List<PlanItem> plan = [];
}

@embedded
class PlanItem {
  int? itemId;
  ProductItem? itemInfo;
  int? itemQty;
  int? itemTotalPrice;
}
