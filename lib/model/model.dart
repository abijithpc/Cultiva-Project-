import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  int phonenumber;

  @HiveField(4)
  String? profileImage;

  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.phonenumber,
      this.profileImage});
}
