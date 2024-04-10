import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/presentation/edit_cart_page/cubit/edit_cart_cubit.dart';
import 'package:grocery_application/presentation/edit_cart_page/view/edit_cart_view.dart';

class EditCartPage extends StatelessWidget {
  static const screenName = '/edit-cart-page';
  final CartItem cartItem;
  const EditCartPage({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCartCubit(),
      child: EditCartView(cartItem: cartItem),
    );
  }
}
