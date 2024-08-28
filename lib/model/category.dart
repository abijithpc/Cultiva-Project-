import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 4)
class Category extends HiveObject {
  @HiveField(0)
  String? name;

  Category({
    required this.name,
  });
}
