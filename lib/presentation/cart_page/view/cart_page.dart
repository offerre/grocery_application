import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/cart_page/bloc/cart_bloc.dart';
import 'package:grocery_application/presentation/cart_page/view/cart_view.dart';

class CartPage extends StatelessWidget {
  static const screenName = '/cart_page';
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocProvider(
        create: (context) => CartBloc(),
        child: const CartView(),
      ),
    );
  }
}
