part of 'add_to_cart_cubit.dart';

@freezed
class AddToCartState with _$AddToCartState {
  const factory AddToCartState({
    @Default(null) Product? product,
    @Default(0) int quantity,
    @Default(0) int totalPrice,
  }) = _AddToCartState;
}
