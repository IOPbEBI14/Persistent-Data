import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pet_shop/src/models/sub_category_item.dart';
import 'package:equatable/equatable.dart';

import '../models/goods_item.dart';

final goodsProvider = FutureProvider.autoDispose
    .family<List<GoodsItem>, SubCategoryItem>((ref, subcategory) async {
  return GoodsProviderClass(subcategory).props;
});

class GoodsProviderClass extends Equatable {
  final SubCategoryItem subcategory;

  const GoodsProviderClass(this.subcategory);

  @override
  List<GoodsItem> get props {
    List<GoodsItem> result = [GoodsItem(subcategory.subcategory, 'This is description')];
    return result;
  }
}
