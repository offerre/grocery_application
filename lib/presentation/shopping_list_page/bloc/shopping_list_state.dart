part of 'shopping_list_bloc.dart';

enum ShoppingListStateStatus { initial, loading, success, failure }

@freezed
class ShoppingListState with _$ShoppingListState {
  const factory ShoppingListState({
    @Default(ShoppingListStateStatus.initial) ShoppingListStateStatus status,
    @Default(null) ProductsResponse? productsResponse,
  }) = _ShoppingListState;
}
