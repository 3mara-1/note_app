import 'package:bloc/bloc.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';
import 'package:note_app/features/presentation/auth/repository/repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  UserRepository userRepository = UserRepository();
    AuthCubit(this.userRepository) : super(AuthInitial());
void fetchUser() {
    final user = userRepository.loadUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthFailure('لا يوجد مستخدم المسجل'));
    }
  }

void updateUser(User newUser) async {
    await userRepository.saveUser(newUser);
    emit(AuthSuccess(newUser));
  }


  //  Future<void> login(String name, {String? imagePath}) async {
  //   if (name.isEmpty) {
  //     emit(AuthFailure('الرجاء إدخال الاسم'));
  //     return;
  //   }
  //   emit(AuthLoading()); 
  //   try {
  //     final box = Hive.box('users');
      
  //     await box.put('name',name); 
  //     if (imagePath != null){
  //       await box.put('imagePath', imagePath);
  //     }
  //     await box.put('isLoggedIn', true); 
  //     emit(AuthSuccess(name));
      
  //   } catch (e) {
  //     emit(AuthFailure('حدث خطأ أثناء الحفظ: ${e.toString()}'));
    // }
  // }
}
