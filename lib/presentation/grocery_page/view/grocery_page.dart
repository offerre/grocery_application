import 'package:flutter/material.dart';
import 'package:grocery_application/presentation/grocery_page/cubit/grocery_cubit.dart';
import 'package:grocery_application/presentation/grocery_page/view/grocery_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceryPage extends StatelessWidget {
  static const screenName = '/';
  const GroceryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroceryCubit(),
      child: const GroceryView(),
    );
  }
}
