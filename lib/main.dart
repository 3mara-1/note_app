import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/core/router/router.dart';
import 'package:note_app/core/theme/theme.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';
import 'package:note_app/features/presentation/auth/repository/repository.dart';
import 'package:note_app/features/presentation/home/Repository/repository.dart';
import 'package:note_app/features/presentation/home/cubit/note_cubit.dart';
import 'package:note_app/features/presentation/home/model/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(NoteAdapter());
  
  await Hive.openBox<User>('users');
  await Hive.openBox<Note>('notes');
  
  runApp(
    const AppProviders(
      
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Note app',
      theme: AppTheme.lightTheme(),
      routerConfig: AppRouter.router,
    );
  }
}

class AppProviders extends StatelessWidget {
  final Widget child;
  
  const AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => NoteRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserCubit( // ✅ تصحيح الاسم
              context.read<UserRepository>(),
            )..loadUser(), // تحميل بيانات المستخدم عند البداية
          ),
          BlocProvider(
            create: (context) => NoteCubit(
              context.read<NoteRepository>(),
            )..loadNotes(), // تحميل الملاحظات عند البداية
          ),
        ],
        child: child,
      ),
    );
  }
}