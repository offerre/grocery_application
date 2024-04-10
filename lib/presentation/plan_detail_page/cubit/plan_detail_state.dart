part of 'plan_detail_cubit.dart';

enum PlanDetailStateStatus { initial, loading, loaded }

@freezed
class PlanDetailState with _$PlanDetailState {
  const factory PlanDetailState({
    @Default(PlanDetailStateStatus.initial) PlanDetailStateStatus status,
    @Default(null) Plan? plan,
  }) = _PlanDetailState;
}
