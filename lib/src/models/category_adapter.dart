import 'package:hive/hive.dart';
import 'package:my_pet_shop/src/models/category_item.dart';

class CategoryAdapter extends TypeAdapter<CategoryItem> {

  @override
  int get typeId => 0;

  @override
  CategoryItem read(BinaryReader reader){
    return CategoryItem(id: reader.readInt(), name:reader.readString(), picture:reader.readString(), subcategories: reader.readStringList());
  }

  @override
  void write(BinaryWriter writer, CategoryItem obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.picture);
    writer.write(obj.subcategories);
  }
}