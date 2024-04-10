import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:isar/isar.dart';

part 'plan_state.dart';
part 'plan_cubit.freezed.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(const PlanState());

  void setTitlePlan(String? title) {
    emit(state.copyWith(titlePlan: title));
  }

  void setNotePlan(String? note) {
    emit(state.copyWith(notePlan: note));
  }

  Future<void> initPlan() async {
    emit(state.copyWith(planStateStatus: PlanStateStatus.loading));
    await isar.txn(() async {
      final plans = await isar.plans.where().findAll();
      emit(state.copyWith(
        planStateStatus: PlanStateStatus.loaded,
        plans: plans,
      ));
    });
  }
}
