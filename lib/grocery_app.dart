import 'package:flutter/material.dart';
import 'package:grocery_application/presentation/grocery_page/view/grocery_page.dart';
import 'package:grocery_application/utils/navigation/route_generator.dart';

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: GroceryPage.screenName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
