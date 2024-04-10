import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/data/remote/products/response/products_response.dart';
import 'package:grocery_application/presentation/add_to_cart_page/cubit/add_to_cart_cubit.dart';
import 'package:grocery_application/presentation/add_to_cart_page/view/add_to_cart_view.dart';

class AddToCartPage extends StatelessWidget {
  static const screenName = '/add-to-cart-page';
  final Product product;
  const AddToCartPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToCartCubit(),
      child: AddToCartView(product: product),
    );
  }
}
