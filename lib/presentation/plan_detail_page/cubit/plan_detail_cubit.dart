import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:isar/isar.dart';

part 'plan_detail_state.dart';
part 'plan_detail_cubit.freezed.dart';

class PlanDetailCubit extends Cubit<PlanDetailState> {
  PlanDetailCubit() : super(const PlanDetailState());

  void setCurrentPlan(Plan plan) {
    emit(state.copyWith(plan: plan));
  }

  void onSavePlanPressed() {
    isar.writeTxnSync(() {
      final currentPlan =
          isar.plans.where().idEqualTo(state.plan?.id ?? -1).findFirstSync();

      if (currentPlan == null) return;

      currentPlan
        ..titlePlan = state.plan?.titlePlan ?? '-'
        ..notePlan = state.plan?.notePlan
        ..isPurchased = state.plan?.isPurchased ?? false
        ..totalPlanPrice = state.plan?.totalPlanPrice ?? 0
        ..plan = state.plan?.plan ?? [];

      isar.plans.putSync(currentPlan);
    });
  }

  void onDeleteItemPressed(int itemId) {
    isar.writeTxnSync(() {
      final currentPlan =
          isar.plans.where().idEqualTo(state.plan?.id ?? -1).findFirstSync();

      if (currentPlan == null) return;

      currentPlan.plan.removeWhere((element) => element.itemId == itemId);
      isar.plans.putSync(currentPlan);
    });
  }

  void onDeleteCurrentPlanPressed() {
    isar.writeTxnSync(() {
      isar.plans.where().idEqualTo(state.plan?.id ?? -1).deleteFirstSync();
    });
  }
}
