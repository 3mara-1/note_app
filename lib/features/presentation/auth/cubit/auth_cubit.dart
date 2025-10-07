import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_state.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';
import 'package:note_app/features/presentation/auth/repository/repository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _repository;

  UserCubit(this._repository) : super(UserInitial());

  // تسجيل الدخول أو إنشاء مستخدم جديد
  Future<void> loginUser({
    required String name,
    String? profilPic,
  }) async {
    try {
      emit(UserLoading());
      
      final user = User(
        name: name,
        profilPic: profilPic,
        isLoggedIn: true,
      );
      
      await _repository.saveUser(user);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('فشل تسجيل الدخول: ${e.toString()}'));
    }
  }

  // جلب بيانات المستخدم الحالي
  void loadUser() {
    try {
      emit(UserLoading());
      
      final user = _repository.loadUser();
      
      if (user != null && user.isLoggedIn) {
        emit(UserLoaded(user));
      } else {
        emit(UserEmpty());
      }
    } catch (e) {
      emit(UserError('فشل تحميل بيانات المستخدم: ${e.toString()}'));
    }
  }

  // تحديث بيانات المستخدم
  Future<void> updateUser({
    String? name,
    String? profilPic,
  }) async {
    try {
      final currentState = state;
      if (currentState is UserLoaded) {
        emit(UserLoading());
        
        final updatedUser = User(
          name: name ?? currentState.user.name,
          profilPic: profilPic ?? currentState.user.profilPic,
          isLoggedIn: currentState.user.isLoggedIn,
        );
        
        await _repository.saveUser(updatedUser);
        emit(UserLoaded(updatedUser));
      }
    } catch (e) {
      emit(UserError('فشل تحديث البيانات: ${e.toString()}'));
    }
  }

  // تسجيل الخروج
  Future<void> logoutUser() async {
    try {
      emit(UserLoading());
      await _repository.deleteUser();
      emit(UserEmpty());
    } catch (e) {
      emit(UserError('فشل تسجيل الخروج: ${e.toString()}'));
    }
  }

  // التحقق من حالة تسجيل الدخول
  bool get isLoggedIn {
    final currentState = state;
    return currentState is UserLoaded && currentState.user.isLoggedIn;
  }
}
