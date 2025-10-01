import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
   Future<void> login(String name, {String? imagePath}) async {
    if (name.isEmpty) {
      emit(AuthFailure('الرجاء إدخال الاسم'));
      return;
    }
    emit(AuthLoading()); 
    try {
      final box = Hive.box('users');
      
      await box.put('name',name); 
      if (imagePath != null){
        await box.put('imagePath', imagePath);
      }
      await box.put('isLoggedIn', true); 
      emit(AuthSuccess(name));
      
    } catch (e) {
      emit(AuthFailure('حدث خطأ أثناء الحفظ: ${e.toString()}'));
    }
  }
}
