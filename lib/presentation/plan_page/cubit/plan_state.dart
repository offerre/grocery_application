part of 'plan_cubit.dart';

enum PlanStateStatus { initial, loading, loaded }

@freezed
class PlanState with _$PlanState {
  const factory PlanState({
    @Default(null) String? titlePlan,
    @Default(null) String? notePlan,
    @Default([]) List<Plan> plans,
    @Default(PlanStateStatus.initial) PlanStateStatus planStateStatus,
  }) = _PlanState;
}
