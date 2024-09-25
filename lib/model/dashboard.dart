// ignore_for_file: camel_case_types

import 'package:hive_flutter/hive_flutter.dart';

part 'dashboard.g.dart';

@HiveType(typeId: 5)
class dashboardData extends HiveObject {
  @HiveField(0)
  int? totalProduct;

  dashboardData({this.totalProduct});
}
