import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:grocery_application/presentation/plan_detail_page/cubit/plan_detail_cubit.dart';
import 'package:grocery_application/presentation/plan_detail_page/view/plan_detail_view.dart';

class PlanDetailPage extends StatelessWidget {
  static const screenName = '/plan-detail-page';
  final Plan plan;
  const PlanDetailPage({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanDetailCubit(),
      child: PlanDetailView(currentPlan: plan),
    );
  }
}
