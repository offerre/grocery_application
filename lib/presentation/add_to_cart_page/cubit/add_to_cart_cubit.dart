import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/data/remote/products/response/products_response.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:isar/isar.dart';

part 'add_to_cart_state.dart';
part 'add_to_cart_cubit.freezed.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(const AddToCartState());

  void setProduct(Product product) {
    emit(state.copyWith(product: product));
  }

  void setQuantity(int quantity) {
    emit(
      state.copyWith(
          quantity: quantity,
          totalPrice: (state.product?.price ?? 0) * quantity),
    );
  }

  void setTotalPrice(int totalPrice) {
    emit(state.copyWith(totalPrice: totalPrice));
  }

  Future<void> addToCart() async {
    await isar.writeTxn(() async {
      final cartItem = await isar.cartItems.where().findFirst() ?? CartItem();

      final product = ProductItem()
        ..id = state.product?.id
        ..brand = state.product?.brand
        ..category = state.product?.category
        ..title = state.product?.title
        ..description = state.product?.description
        ..price = state.product?.price
        ..thumbnail = state.product?.thumbnail
        ..images = state.product?.images;

      cartItem
        ..id = state.product?.id ?? 0
        ..productItem = product
        ..quantity = state.quantity
        ..totalPrice = state.totalPrice;

      await isar.cartItems.put(cartItem);
    });
  }
}
