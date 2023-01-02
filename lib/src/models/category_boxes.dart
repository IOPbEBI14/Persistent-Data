import 'package:hive/hive.dart';
import 'package:my_pet_shop/src/models/category_adapter.dart';

const List<String> categories = ['{"id":1,"name":"Товары для Кошек", "picture":"rabbit_cats.png","subcategories":["Еда","Туалет"]}',
  '{"id":2,"name":"Товары для Собак", "picture":"rabbit_dogz.png","subcategories":["Еда","Туалет"]}',
  '{"id":3,"name":"Товары для Грызунов", "picture":"rabbit_hamsters.png","subcategories":["Еда","Туалет"]}',
  '{"id":4,"name":"Товары для Птиц", "picture":"rabbit_birds.png","subcategories":["Еда","Туалет"]}',
  '{"id":5,"name":"Товары для Рыб", "picture":"rabbit_aquarium.png","subcategories":["Еда","Туалет"]}',
  '{"id":6,"name":"Лежаки, лежанки", "picture":"  ","subcategories":["Еда","Туалет"]}',
  '{"id":7,"name":"Аксессуары для животных", "picture":"  ","subcategories":["Еда","Туалет"]}',
  '{"id":9,"name":"Амуниция для кошек и собак", "picture":"  ","subcategories":["Еда","Туалет"]}',
  '{"id":10,"name":"Витамины и микроэлементы", "picture":"  ","subcategories":["Еда","Туалет"]}',
  '{"id":10,"name":"Гигиена", "picture":"  ","subcategories":["Еда","Туалет"]}',
  '{"id":12,"name":"Груминг", "picture":"  ","subcategories":["Еда","Туалет"]}',
  '{"id":13,"name":"Контакты", "picture":"rabbit_contacts.png","subcategories":["Директор","Продавец"]}'];

class CategoryBoxes {
  late Box<List<String>> box;

  Future<List<String>> getCategoriesFromBox() async {
    List<String>? result;

    Hive.registerAdapter(CategoryAdapter());
    box = await Hive.openBox('categories');
    result = box.get('key');
    try {
      return Future.value(categories);
    } catch (e) {
      return Future.value(categories);
    }
  }

  void saveCategory(List<String> categories) {
    box.put('key', categories);
  }
}
