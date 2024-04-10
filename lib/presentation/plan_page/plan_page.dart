import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/plan_page/cubit/plan_cubit.dart';
import 'package:grocery_application/presentation/plan_page/view/plan_view.dart';

class PlanPage extends StatelessWidget {
  static const screenName = '/plan_page';
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanCubit(),
      child: const PlanView(),
    );
  }
}
