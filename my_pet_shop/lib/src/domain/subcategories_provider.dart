import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pet_shop/src/models/category_item.dart';
import 'package:my_pet_shop/src/models/sub_category_item.dart';
import 'package:equatable/equatable.dart';

final subcategoriesProvider = FutureProvider.autoDispose
    .family<List<SubCategoryItem>, CategoryItem>((ref, category) async {
  return SubCategoriesProviderClass(category).props;
});

class SubCategoriesProviderClass extends Equatable {
  final CategoryItem category;

  const SubCategoriesProviderClass(this.category);

  @override
  List<SubCategoryItem> get props {
    List<SubCategoryItem> result = [];
    for (String item in category.subcategories) {
      result = [...result, SubCategoryItem(item)];
    }
    return result;
  }
}
