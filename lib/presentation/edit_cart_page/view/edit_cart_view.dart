import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/presentation/edit_cart_page/cubit/edit_cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:isar/isar.dart';

class EditCartView extends StatelessWidget {
  final CartItem cartItem;
  const EditCartView({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditCartCubit>();
    cubit.setCartItem(cartItem);

    final existingItem =
        isar.cartItems.where().idEqualTo(cartItem.id).findFirstSync();

    final initialQty = existingItem?.quantity;
    final initialTotalPrice = existingItem?.totalPrice;
    cubit.setQuantity(initialQty ?? 0);
    cubit.setTotalPrice(initialTotalPrice ?? 0);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(cartItem.productItem?.title ?? ''),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Product Image
          Image.network(cartItem.productItem?.thumbnail ?? ''),
          const SizedBox(height: 16),
          // Title
          Text(
            'Product: ${cartItem.productItem?.title}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text('Description: ${cartItem.productItem?.description}'),
          const SizedBox(height: 8),

          // Price
          Text(
            'Price: ${cartItem.productItem?.price} \$',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Quantity
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Quantity',
              hintText: 'amount',
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            initialValue: (initialQty ?? '').toString(),
            onChanged: (value) {
              if (value.isNotEmpty) {
                cubit.setQuantity(int.parse(value));
              } else {
                cubit.setQuantity(0);
              }
            },
          ),
          const SizedBox(height: 16),
          // Total Price
          BlocBuilder<EditCartCubit, EditCartState>(
            builder: (context, state) {
              return Text(
                'Total Price: ${cubit.state.totalPrice} \$',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    cubit.saveToCart();
                    Navigator.of(context).pop();
                  },
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
      ),
    );
  }
}
