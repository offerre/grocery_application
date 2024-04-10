part of 'edit_cart_cubit.dart';

@freezed
class EditCartState with _$EditCartState {
  const factory EditCartState({
    @Default(null) CartItem? cartItem,
    @Default(0) int quantity,
    @Default(0) int totalPrice,
  }) = _EditCartState;
}
