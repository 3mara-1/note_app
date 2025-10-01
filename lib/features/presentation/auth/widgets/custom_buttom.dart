import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/model/user_model.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.name, this.imagePath});
  String name;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (name.isNotEmpty) {
              final userToLogin = User(name, imagePath);
              context.read<AuthCubit>().updateUser(userToLogin);
              context.go('/home');
              print(name.toString() + '' + imagePath.toString());
            } else {}
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorStyle.primaryContainer,
            minimumSize: Size(330, 60),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 2),
            ),
          ),
          child: Text('get started', style: textStyle.bodyLarge),
        );
      },
    );
  }
}
