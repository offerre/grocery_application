import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/create_new_plan_page/cubit/create_new_plan_cubit.dart';
import 'package:grocery_application/presentation/create_new_plan_page/view/create_new_plan_view.dart';

class CreateNewPlanPageArgs {
  String title;
  String? note;

  CreateNewPlanPageArgs({required this.title, this.note});
}

class CreateNewPlanPage extends StatelessWidget {
  static const screenName = '/create-new-plan-page';
  const CreateNewPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNewPlanCubit(),
      child: const CreateNewPlanView(),
    );
  }
}
