import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/shopping_list_page/bloc/shopping_list_bloc.dart';
import 'package:grocery_application/presentation/shopping_list_page/view/shopping_list_view.dart';

class ShoppingListPage extends StatelessWidget {
  static const screenName = '/shopping_list_page';
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => ShoppingListBloc(),
      child: const ShoppingListView(),
    ));
  }
}
