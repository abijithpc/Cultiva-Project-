import 'package:cultiva/model/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<User?> fetchDetails() async {
  final authBox = await Hive.openBox('authBox');
  final currentIndex = authBox.get('currentUserIndex', defaultValue: 0);

  final box = Hive.box<User>('userBox');
  final user = box.getAt(currentIndex);

  return user;
}
