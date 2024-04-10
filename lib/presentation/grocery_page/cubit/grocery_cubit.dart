import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'grocery_state.dart';
part 'grocery_cubit.freezed.dart';

class GroceryCubit extends Cubit<GroceryState> {
  GroceryCubit() : super(const GroceryState.initial(currentIndex: 0));

  void updateIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
