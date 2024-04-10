part of 'create_new_plan_cubit.dart';

@freezed
class CreateNewPlanState with _$CreateNewPlanState {
  const factory CreateNewPlanState({
    @Default(null) String? title,
    @Default(null) String? note,
  }) = _CreateNewPlanState;
}
