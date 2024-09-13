import 'package:hive_flutter/hive_flutter.dart';

part 'dashboard.g.dart';

@HiveType(typeId: 5)
class DashboardData extends HiveObject {
  @HiveField(0)
  int? totalProduct;

  DashboardData({this.totalProduct});
}
