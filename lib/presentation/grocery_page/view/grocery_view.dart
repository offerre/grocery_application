import 'package:flutter/material.dart';
import 'package:grocery_application/presentation/cart_page/view/cart_page.dart';
import 'package:grocery_application/presentation/grocery_page/cubit/grocery_cubit.dart';

import '../../plan_page/plan_page.dart';
import '../../shopping_list_page/view/shopping_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceryView extends StatelessWidget {
  const GroceryView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ShoppingListPage(),
      const CartPage(),
      const PlanPage(),
    ];

    return Scaffold(
      body: BlocBuilder<GroceryCubit, GroceryState>(
        builder: (context, state) {
          return pages[state.currentIndex];
        },
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: context.watch<GroceryCubit>().state.currentIndex,
          onDestinationSelected: (index) =>
              context.read<GroceryCubit>().updateIndex(index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.local_grocery_store_outlined),
              selectedIcon: Icon(
                Icons.local_grocery_store,
                color: Colors.green,
              ),
              label: 'Shopping',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              selectedIcon: Icon(
                Icons.shopping_bag_rounded,
                color: Colors.green,
              ),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.note_alt_outlined),
              selectedIcon: Icon(
                Icons.note_alt,
                color: Colors.green,
              ),
              label: 'Plan',
            ),
          ]),
    );
  }
}
