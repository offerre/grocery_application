part of 'grocery_cubit.dart';

@freezed
class GroceryState with _$GroceryState {
  const factory GroceryState.initial({
    @Default(0) int currentIndex,
  }) = _Initial;
}
