import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:isar/isar.dart';

import '../../../data/database/model/cart/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartEvent>((event, emit) {
      event.when(
        onCartItemsFetched: () async => await _initCartDB(emit),
        onDeleteItemPressed: (cartItem) async =>
            await _deleteCartItem(emit, cartItem),
        onPriceUpdated: () async => await _onPriceUpdated(emit),
        onSaveToPlanPressed: () async => await _onSaveToPlan(emit, false),
        onPurchasedPressed: () async => await _onSaveToPlan(emit, true),
        onSetNewPlan: (title, note) => _setNewPlan(emit, title, note),
      );
    });
  }

  Future<void> _initCartDB(Emitter<CartState> emit) async {
    emit(state.copyWith(cartStateStatus: CartStateStatus.loading));
    await isar.txnSync(() async {
      final cartItems = isar.cartItems.where().findAllSync();
      emit(state.copyWith(
        cartStateStatus: CartStateStatus.loaded,
        cartItems: cartItems,
      ));
    });
  }

  Future<void> _deleteCartItem(
      Emitter<CartState> emit, CartItem? cartItem) async {
    await isar.writeTxn(() async {
      await isar.cartItems.delete(cartItem?.id ?? -1);
    });
  }

  Future<void> _onPriceUpdated(Emitter<CartState> emit) async {
    await isar.writeTxnSync(() async {
      final totalCartPrice =
          isar.cartItems.where().totalPriceProperty().sumSync();
      emit(state.copyWith(totalCartPrice: totalCartPrice));
    });
  }

  void _setNewPlan(Emitter<CartState> emit, String title, String? note) {
    emit(state.copyWith(title: title, note: note));
  }

  Future<void> _onSaveToPlan(Emitter<CartState> emit, bool isPurchased) async {
    await isar.writeTxnSync(() async {
      final plan = Plan();
      final planItems = state.cartItems
          .map(
            (e) => PlanItem()
              ..itemId = e.id
              ..itemInfo = e.productItem
              ..itemQty = e.quantity
              ..itemTotalPrice = e.totalPrice,
          )
          .toList();

      if (state.title != null) {
        plan
          ..titlePlan = state.title ?? '-'
          ..notePlan = state.note
          ..plan = planItems
          ..totalPlanPrice = state.totalCartPrice
          ..isPurchased = isPurchased;

        isar.plans.putSync(plan);
        // clear title and note after saved plan
        isar.cartItems.where().deleteAllSync();
        emit(state.copyWith(
          cartItems: [],
          title: null,
          note: null,
        ));
      }
    });
  }
}
