
import 'package:hive/hive.dart';
import 'package:my_pet_shop/src/models/category_adapter.dart';

class CategoryBoxes {
late Box<List<String>> box;

  Future<List<String>> getCategoriesFromBox() async {
    List<String>? result;
    Hive.registerAdapter(CategoryAdapter());
    box = await Hive.openBox('categories');
    result=box.get('key');
    return Future.value(result);
  }

  void saveCategory(List<String> categories){
    box.put('key', categories);
  }
}