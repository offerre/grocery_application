import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:grocery_application/data/remote/products/response/products_response.dart';
import 'package:grocery_application/data/service/shopping_service.dart';
import 'package:grocery_application/main.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';
part 'shopping_list_bloc.freezed.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final ShoppingService shoppingService = getIt<ShoppingService>();

  ShoppingListBloc()
      : super(const ShoppingListState(
          status: ShoppingListStateStatus.initial,
        )) {
    on<ShoppingListEvent>((event, emit) async {
      await event.when(
        onFetchDataPressed: (offSet, limit) async =>
            await _onFetchDataPressed(emit, offSet, limit),
      );
    });
  }

  Future<void> _onFetchDataPressed(
    Emitter<ShoppingListState> emit,
    int offSet,
    int limit,
  ) async {
    emit(const ShoppingListState(status: ShoppingListStateStatus.loading));
    final result = await shoppingService.fetchProductList(offSet, limit);
    emit(ShoppingListState(
      status: ShoppingListStateStatus.success,
      productsResponse: result,
    ));
  }
}
