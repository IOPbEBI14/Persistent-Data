import 'dart:convert';

import '../models/category_boxes.dart';
import '../models/category_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MyHotelEvents { addHotelInList, removeHotelFromList }

final myCategoriesListProvider =
    StateNotifierProvider<MyCategoriesList, List<CategoryItem>>(
        (_) => MyCategoriesList());

class MyCategoriesList extends StateNotifier<List<CategoryItem>> {
  CategoryBoxes boxes = CategoryBoxes();

  MyCategoriesList() : super([]) {
    final categories = boxes.getCategoriesFromBox();
    state = [];
    categories.then((value) {
      for (var element in value) {
        state = [...state, CategoryItem.fromJson(jsonDecode(element))];
      }
    });
  }

  void addCategoryInList(CategoryItem item) {
    List<String> categories = [];
    state = [...state, item];
    for (var element in state) {
      categories.add(element.toJson().toString());
    }
    boxes.saveCategory(categories);
  }

  void updateSubcategory(CategoryItem item) {
    List<String> categories = [];
    for (var element in state) {
      if (element.id == item.id) {
        categories.add(item.toJson().toString());
      } else {
        categories.add(element.toJson().toString());
      }
    }
    boxes.saveCategory(categories);
  }
}
