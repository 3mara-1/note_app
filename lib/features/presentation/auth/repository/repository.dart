import 'package:hive/hive.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';

class UserRepository {
  Box<User> get _box => Hive.box<User>('users');

  Future<void> saveUser(User user) async {
    await _box.put('currentUser', user);
  }

  User? loadUser() {
    return _box.get('currentUser');
  }

  Future<void> deleteUser() async {
    await _box.delete('currentUser');
  }

  bool hasUser() {
    return _box.containsKey('currentUser');
  }

  Future<void> updateProfilePic(String? profilePic) async {
    final user = loadUser();
    if (user != null) {
      final updatedUser = User(
        name: user.name,
        profilPic: profilePic,
        isLoggedIn: user.isLoggedIn,
      );
      await saveUser(updatedUser);
    }
  }

  Future<void> updateName(String name) async {
    final user = loadUser();
    if (user != null) {
      final updatedUser = User(
        name: name,
        profilPic: user.profilPic,
        isLoggedIn: user.isLoggedIn,
      );
      await saveUser(updatedUser);
    }
  }

  Future<void> updateLoginStatus(bool isLoggedIn) async {
    final user = loadUser();
    if (user != null) {
      user.isLoggedIn = isLoggedIn;
      await user.save();
    }
  }
}