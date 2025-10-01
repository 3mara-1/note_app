import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => context.go('/register'),
    );
  }
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorStyle.surface,
      body: SafeArea(
        child: Center(
          child: Text(
            'Note App',
            textAlign: TextAlign.center,
            style: textStyle.headlineLarge,
          ),
        ),
      ),
    );
  }
}
