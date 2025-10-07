import 'package:hive/hive.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';

class UserRepository {
  // الحصول على الصندوق
  Box<User> get _box => Hive.box<User>('users');

  // حفظ بيانات المستخدم
  Future<void> saveUser(User user) async {
    await _box.put('currentUser', user);
  }

  // جلب بيانات المستخدم
  User? loadUser() {
    return _box.get('currentUser');
  }

  // حذف بيانات المستخدم (تسجيل الخروج)
  Future<void> deleteUser() async {
    await _box.delete('currentUser');
  }

  // التحقق من وجود مستخدم مسجل
  bool hasUser() {
    return _box.containsKey('currentUser');
  }

  // تحديث صورة البروفايل
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

  // تحديث الاسم
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

  // تحديث حالة تسجيل الدخول
  Future<void> updateLoginStatus(bool isLoggedIn) async {
    final user = loadUser();
    if (user != null) {
      user.isLoggedIn = isLoggedIn;
      await user.save();
    }
  }
}