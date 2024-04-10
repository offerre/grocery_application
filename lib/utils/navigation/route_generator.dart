import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:grocery_application/data/remote/products/response/products_response.dart';
import 'package:grocery_application/presentation/add_to_cart_page/view/add_to_cart_page.dart';
import 'package:grocery_application/presentation/cart_page/view/cart_page.dart';
import 'package:grocery_application/presentation/create_new_plan_page/view/create_new_plan_page.dart';
import 'package:grocery_application/presentation/edit_cart_page/view/edit_cart_page.dart';
import 'package:grocery_application/presentation/grocery_page/view/grocery_page.dart';
import 'package:grocery_application/presentation/plan_detail_page/view/plan_detail_page.dart';
import 'package:grocery_application/presentation/plan_page/plan_page.dart';
import 'package:grocery_application/presentation/shopping_list_page/view/shopping_list_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      debugPrint('ROUTE:: ${settings.name}');
    }
    switch (settings.name) {
      case GroceryPage.screenName:
        return MaterialPageRoute(
          builder: (context) => const GroceryPage(),
        );
      case ShoppingListPage.screenName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ShoppingListPage(),
        );
      case PlanPage.screenName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PlanPage(),
        );
      case CartPage.screenName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CartPage(),
        );
      case AddToCartPage.screenName:
        final args = settings.arguments as Product;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => AddToCartPage(product: args),
        );
      case EditCartPage.screenName:
        final args = settings.arguments as CartItem;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => EditCartPage(
            cartItem: args,
          ),
        );
      case CreateNewPlanPage.screenName:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CreateNewPlanPage(),
        );
      case PlanDetailPage.screenName:
        final args = settings.arguments as Plan;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => PlanDetailPage(plan: args),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('404 - Route Not Found')),
        );
      },
    );
  }
}
