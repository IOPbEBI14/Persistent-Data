import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pet_shop/src/models/sub_category_item.dart';

import '../domain/goods_provider.dart';

/// Displays detailed information about a SampleItem.
class GoodsView extends ConsumerWidget {
  SubCategoryItem subCategory;

  GoodsView({Key? key, required this.subCategory}) : super(key: key);

  static const routeName = '/goods_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subcategories = ref.watch(goodsProvider(subCategory));
    return Scaffold(
      appBar: AppBar(
        title: Text(subCategory.subcategory),
      ),
      body: subcategories.when(
          data: (subcats) => Center(child: Text(subcats[0].description)),
          error: (err, stack) => Center(child: Text(err.toString())),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => null,
      ),
    );
  }
}
