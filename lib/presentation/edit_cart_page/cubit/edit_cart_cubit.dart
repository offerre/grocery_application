import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:isar/isar.dart';

part 'edit_cart_state.dart';
part 'edit_cart_cubit.freezed.dart';

class EditCartCubit extends Cubit<EditCartState> {
  EditCartCubit() : super(const EditCartState());

  void setCartItem(CartItem cartItem) {
    emit(state.copyWith(cartItem: cartItem));
  }

  void setQuantity(int quantity) {
    emit(state.copyWith(
      quantity: quantity,
      totalPrice: (state.cartItem?.productItem?.price ?? 0) * quantity,
    ));
  }

  void setTotalPrice(int totalPrice) {
    emit(state.copyWith(totalPrice: totalPrice));
  }

  Future<void> saveToCart() async {
    await isar.writeTxn(() async {
      final cartItem = await isar.cartItems
              .where()
              .idEqualTo(state.cartItem?.id ?? -1)
              .findFirst() ??
          CartItem();

      cartItem
        ..quantity = state.quantity
        ..totalPrice = state.totalPrice;

      await isar.cartItems.put(cartItem);
    });
  }
}
