import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 3)
class Category extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? iconpath;

  Category({
    required this.name,
    required this.iconpath,
  });
}
