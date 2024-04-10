part of 'cart_bloc.dart';

enum CartStateStatus { initial, loading, loaded }

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(CartStateStatus.initial) CartStateStatus cartStateStatus,
    @Default(null) String? title,
    @Default(null) String? note,
    @Default([]) List<CartItem> cartItems,
    @Default(0) int totalCartPrice,
  }) = _CartState;
}
