import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/create_new_plan_page/cubit/create_new_plan_cubit.dart';
import 'package:grocery_application/presentation/create_new_plan_page/view/create_new_plan_page.dart';

class CreateNewPlanView extends StatelessWidget {
  const CreateNewPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Create new plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CreateNewPlanCubit, CreateNewPlanState>(
          builder: (context, state) {
            final cubit = context.read<CreateNewPlanCubit>();
            return Column(
              children: [
                //Title plan
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'title plan',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9 !@#$%^&*()_+-.]'),
                    )
                  ],
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      cubit.setTitle(value);
                    } else {
                      cubit.setTitle(null);
                    }
                  },
                ),
                //Note plan
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    hintText: 'additional note',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9 !@#$%^&*()_+-.]'),
                    )
                  ],
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      cubit.setNote(value);
                    } else {
                      cubit.setNote(null);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: state.title == null
                            ? null
                            : () {
                                // cubit.onCreateNewListPressed(
                                //     state.title!, state.note);
                                Navigator.of(context).pop(CreateNewPlanPageArgs(
                                  title: state.title!,
                                  note: state.note,
                                ));
                              },
                        child: const Text('Create new plan'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
