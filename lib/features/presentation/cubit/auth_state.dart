part of 'auth_cubit.dart';


sealed class AuthState {}

final class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {} // حالة الانتظار عند الضغط على تسجيل الدخول

class AuthSuccess extends AuthState { // حالة النجاح بعد تسجيل الدخول
  final String name;
  AuthSuccess(this.name);
}
class AuthFailure extends AuthState { // حالة الفشل
  final String error;
  AuthFailure(this.error);
}