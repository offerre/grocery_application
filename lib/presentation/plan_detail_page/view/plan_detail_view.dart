import 'package:flutter/material.dart';
import 'package:grocery_application/data/database/model/plan/plan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/plan_detail_page/cubit/plan_detail_cubit.dart';

class PlanDetailView extends StatelessWidget {
  final Plan currentPlan;
  const PlanDetailView({super.key, required this.currentPlan});

  @override
  Widget build(BuildContext context) {
    context.read<PlanDetailCubit>().setCurrentPlan(currentPlan);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(currentPlan.titlePlan),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: currentPlan.plan.length,
                itemBuilder: (context, index) {
                  final imageUrl = currentPlan.plan[index].itemInfo?.thumbnail;
                  final itemTitle =
                      currentPlan.plan[index].itemInfo?.title ?? '-';
                  final itemDescription =
                      currentPlan.plan[index].itemInfo?.description ?? '-';
                  final itemPrice =
                      currentPlan.plan[index].itemInfo?.price ?? 0;
                  final itemQty = currentPlan.plan[index].itemQty ?? 0;
                  return ListTile(
                    leading: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            width: 50,
                          )
                        : CircleAvatar(
                            child: Text(itemTitle[0]),
                          ),
                    title: Text(
                      itemTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'Detail: $itemDescription',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$itemPrice \$ x $itemQty',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Note plan
              Text(
                'Note: ${currentPlan.notePlan}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              // Total price
              Text(
                'Total Price: ${currentPlan.totalPlanPrice}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              // Delete Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Do delete current plan and pop
                    context
                        .read<PlanDetailCubit>()
                        .onDeleteCurrentPlanPressed();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text(
                    'Delete plan',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
