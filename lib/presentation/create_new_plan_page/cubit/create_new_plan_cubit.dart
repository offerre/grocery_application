import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:grocery_application/utils/database/isar_db.dart';

part 'create_new_plan_state.dart';
part 'create_new_plan_cubit.freezed.dart';

class CreateNewPlanCubit extends Cubit<CreateNewPlanState> {
  CreateNewPlanCubit() : super(const CreateNewPlanState());

  void setTitle(String? title) {
    emit(state.copyWith(title: title));
  }

  void setNote(String? note) {
    emit(state.copyWith(note: note));
  }

  Future<void> onCreateNewListPressed(String title, String? notePlan) async {
    await isar.writeTxn(() async {
      final plan = Plan();
      if (state.title != null) {
        plan
          ..titlePlan = title
          ..notePlan = notePlan;
        await isar.plans.put(plan);
      }
    });
  }
}
