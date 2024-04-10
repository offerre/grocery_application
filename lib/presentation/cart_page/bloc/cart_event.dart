part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.onCartItemsFetched() = _onCartItemsFetched;
  const factory CartEvent.onDeleteItemPressed({
    @Default(null) CartItem? cartItem,
  }) = _onDeletePressed;
  const factory CartEvent.onPriceUpdated() = _onPriceUpdated;
  const factory CartEvent.onSaveToPlanPressed() = _onSaveToPlanPressed;
  const factory CartEvent.onPurchasedPressed() = _onPurchasedPressed;
  const factory CartEvent.onSetNewPlan(String title, String? note) =
      _onSetNewPlan;
}
