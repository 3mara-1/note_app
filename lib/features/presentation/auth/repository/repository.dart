// user_repository.dart
import 'package:hive/hive.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';

class UserRepository {
  Future<void> saveUser(User user) async {
    final box = Hive.box<User>('users');
    await box.put('currentUser', user);
  }

  User? loadUser() {
    final box = Hive.box<User>('users');
    return box.get('currentUser');
  }

  Future<void> deleteUser() async {
    final box = Hive.box<User>('users');
    await box.delete('currentUser');
  }
}