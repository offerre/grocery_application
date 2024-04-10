import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/presentation/cart_page/bloc/cart_bloc.dart';
import 'package:grocery_application/presentation/create_new_plan_page/view/create_new_plan_page.dart';
import 'package:grocery_application/presentation/edit_cart_page/view/edit_cart_page.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    bloc.add(const CartEvent.onCartItemsFetched());

    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        bloc: bloc..add(const CartEvent.onPriceUpdated()),
        builder: (context, state) {
          switch (bloc.state.cartStateStatus) {
            case CartStateStatus.initial:
              return const Center(
                child: Text('No item in cart.'),
              );
            case CartStateStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case CartStateStatus.loaded:
              if (bloc.state.cartItems.isEmpty) {
                return const Center(
                  child: Text('No item in cart.'),
                );
              }
              return BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 320,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: bloc.state.cartItems.length,
                            itemBuilder: (context, index) {
                              final cartItem = bloc.state.cartItems[index];
                              final productItem = cartItem.productItem;
                              final imageUrl = productItem?.thumbnail;
                              final itemTitle = productItem?.title ?? '-';
                              final itemDescription =
                                  productItem?.description ?? '-';
                              final itemPrice = productItem?.price ?? 0;
                              final itemQty = cartItem.quantity ?? 0;
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
                                    const SizedBox(width: 16),
                                    InkWell(
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onTap: () async {
                                        await Navigator.of(context).pushNamed(
                                          EditCartPage.screenName,
                                          arguments: cartItem,
                                        );
                                        bloc.add(
                                            const CartEvent.onPriceUpdated());
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onTap: () async {
                                        bloc.add(CartEvent.onDeleteItemPressed(
                                          cartItem: cartItem,
                                        ));
                                        setState(() {});
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Total price
                        Text(
                          'Total Price: ${bloc.state.totalCartPrice} \$',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('Purchase'),
                                  onPressed: () async {
                                    final result =
                                        await Navigator.of(context).pushNamed(
                                      CreateNewPlanPage.screenName,
                                    ) as CreateNewPlanPageArgs?;
                                    // Create new plan with purchased status
                                    if (result != null) {
                                      bloc.add(CartEvent.onSetNewPlan(
                                          result.title, result.note));
                                      bloc.add(
                                          const CartEvent.onPurchasedPressed());
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  child: const Text('Save to Plan'),
                                  onPressed: () async {
                                    final result =
                                        await Navigator.of(context).pushNamed(
                                      CreateNewPlanPage.screenName,
                                    ) as CreateNewPlanPageArgs?;
                                    // Create new plan with just for save
                                    if (result != null) {
                                      bloc.add(CartEvent.onSetNewPlan(
                                          result.title, result.note));
                                      bloc.add(const CartEvent
                                          .onSaveToPlanPressed());
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
