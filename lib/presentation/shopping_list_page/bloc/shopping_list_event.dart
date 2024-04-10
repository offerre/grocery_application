part of 'shopping_list_bloc.dart';

@freezed
class ShoppingListEvent with _$ShoppingListEvent {
  const factory ShoppingListEvent.onFetchDataPressed(int offSet, int limit) =
      _onFetchDataPressed;
}
