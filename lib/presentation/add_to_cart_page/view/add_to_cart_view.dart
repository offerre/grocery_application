import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/data/remote/products/response/products_response.dart';
import 'package:grocery_application/presentation/add_to_cart_page/cubit/add_to_cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:isar/isar.dart';

class AddToCartView extends StatelessWidget {
  final Product product;
  const AddToCartView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    int quantity;

    final cubit = context.read<AddToCartCubit>();
    cubit.setProduct(product);

    final exsitingItem =
        isar.cartItems.where().idEqualTo(product.id ?? -1).findFirstSync();

    final initialQty = exsitingItem?.quantity;
    final initialTotalPrice = exsitingItem?.totalPrice;
    cubit.setQuantity(initialQty ?? 0);
    cubit.setTotalPrice(initialTotalPrice ?? 0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(product.title ?? ''),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Product Image
          Image.network(product.thumbnail ?? ''),
          const SizedBox(height: 16),
          // Title
          Text(
            'Product: ${product.title}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text('Description: ${product.description}'),
          const SizedBox(height: 8),

          // Price
          Text(
            'Price: ${product.price} \$',
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
                quantity = int.parse(value);
                cubit.setQuantity(quantity);
              } else {
                cubit.setQuantity(0);
              }
            },
          ),
          const SizedBox(height: 16),
          // Total Price
          BlocBuilder<AddToCartCubit, AddToCartState>(
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
                  child: Text(exsitingItem == null ? 'Add to Cart' : 'Save'),
                  onPressed: () {
                    cubit.addToCart();
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
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
