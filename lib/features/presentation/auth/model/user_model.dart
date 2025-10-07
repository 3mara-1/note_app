import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final String? profilPic;
  
  @HiveField(2)
  bool isLoggedIn;

  User({
    required this.name,
    this.profilPic,
    this.isLoggedIn = false,
  });
}