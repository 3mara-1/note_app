import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() {
    Timer(const Duration(seconds: 4), () {
      final userState = context.read<UserCubit>().state;
      
      if (userState is UserLoaded && userState.user.isLoggedIn) {
        context.go('/home');
      } else {
        context.go('/register');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorStyle.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Note App',
                textAlign: TextAlign.center,
                style: textStyle.headlineLarge,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
