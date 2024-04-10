import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/plan_detail_page/view/plan_detail_page.dart';
import 'package:grocery_application/presentation/plan_page/cubit/plan_cubit.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Plan'),
      ),
      body: BlocBuilder<PlanCubit, PlanState>(
        bloc: context.read<PlanCubit>()..initPlan(),
        builder: (context, state) {
          final cubit = context.read<PlanCubit>();
          switch (state.planStateStatus) {
            case PlanStateStatus.initial:
            case PlanStateStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PlanStateStatus.loaded:
              if (cubit.state.plans.isEmpty) {
                return const Center(child: Text('There is no plan yet.'));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: cubit.state.plans.length,
                  itemBuilder: (context, index) {
                    final titlePlan = cubit.state.plans[index].titlePlan;
                    final isPurchased = cubit.state.plans[index].isPurchased;
                    final firstImage =
                        cubit.state.plans[index].plan[0].itemInfo?.thumbnail;
                    final notePlan = cubit.state.plans[index].notePlan ?? '-';

                    return InkWell(
                      onTap: () async {
                        // Navigate to plan detail page by passing Plan.
                        final selectedPlan = cubit.state.plans[index];
                        await Navigator.of(context).pushNamed(
                          PlanDetailPage.screenName,
                          arguments: selectedPlan,
                        );
                        setState(() {});
                      },
                      child: Card(
                        child: Column(
                          children: [
                            if (firstImage != null)
                              Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: NetworkImage(firstImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ListTile(
                              leading: CircleAvatar(
                                child: Icon(
                                  isPurchased
                                      ? Icons.done
                                      : Icons.access_time_outlined,
                                  color: isPurchased
                                      ? Colors.green
                                      : Colors.amber.shade700,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    titlePlan,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  // Note
                                  Text(
                                    'Note: $notePlan',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.zoom_in),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
