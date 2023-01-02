import 'package:hive/hive.dart';
part 'category_item.g.dart';

@HiveType(typeId: 0)
class CategoryItem {
  CategoryItem(
      {required this.id,
      required this.name,
      required this.picture,
      required this.subcategories});

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String picture;
  @HiveField(3)
  final List<String> subcategories;

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json["id"] as int,
        name: json['name'] as String,
        picture: json['picture'] as String,
        subcategories: (json['subcategories'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
      );

  Map<String, dynamic> toJson() => _categoryItemToJson(this);

  Map<String, dynamic> _categoryItemToJson(CategoryItem instance) =>
      <String, dynamic>{
        '"id"': instance.id,
        '"name"': '"${instance.name}"',
        '"picture"': '"${instance.picture}"',
        '"subcategories"': List<dynamic>.from(instance.subcategories.map((x) => '"$x"')),
      };
}
