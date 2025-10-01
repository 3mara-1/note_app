import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/core/router/router.dart';
import 'package:note_app/core/theme/theme.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';
import 'package:note_app/features/presentation/auth/repository/repository.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  // await Hive.openBox('users');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(UserRepository())..fetchUser(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Note app',
        theme: AppTheme.lightTheme(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
