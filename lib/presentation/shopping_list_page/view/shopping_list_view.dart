import 'package:flutter/material.dart';
import 'package:grocery_application/data/database/model/cart/cart_item.dart';
import 'package:grocery_application/data/service/shopping_service.dart';
import 'package:grocery_application/main.dart';
import 'package:grocery_application/presentation/add_to_cart_page/view/add_to_cart_page.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:isar/isar.dart';

import '../../../data/remote/products/response/products_response.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  final _pagingController = PagingController<int, Product>(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final result =
          await getIt<ShoppingService>().fetchProductList(pageKey, 30);
      final newItems = result.products ?? [];
      final totalPrvItems = _pagingController.itemList?.length ?? 0;
      final totalNewItems = newItems.length;
      final totalApiResources = result.total ?? 0;
      final pageLimit = result.limit ?? 0;

      final isLastPage = totalNewItems < pageLimit ||
          (totalPrvItems + totalNewItems) >= totalApiResources;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedGridView(
            pagingController: _pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            showNewPageErrorIndicatorAsGridChild: false,
            showNewPageProgressIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            builderDelegate: PagedChildBuilderDelegate<Product>(
              itemBuilder: (context, item, index) {
                final isExisting = isar.cartItems
                    .where()
                    .idEqualTo(item.id ?? -1)
                    .findFirstSync();
                return Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.network(
                            item.thumbnail ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          item.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${item.price} \$',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final result =
                                    await Navigator.of(context).pushNamed(
                                  AddToCartPage.screenName,
                                  arguments: item,
                                );
                                if (result as bool == true) {
                                  setState(() {});
                                }
                              },
                              child: Icon(
                                isExisting == null ? Icons.add : Icons.edit,
                                color: isExisting == null ? null : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
