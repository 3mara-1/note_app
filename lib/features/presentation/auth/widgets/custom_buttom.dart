import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_state.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.name,
    this.imagePath,
    required this.formKey,
  });

  final String name;
  final String? imagePath;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;
    
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoaded) {
          context.go('/home');
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is UserLoading;
        
        return ElevatedButton(
          onPressed: isLoading ? null : () async {
            if (formKey.currentState?.validate() ?? false) {
              await context.read<UserCubit>().loginUser(
                name: name,
                profilPic: imagePath,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorStyle.primaryContainer,
            minimumSize: const Size(330, 60),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(width: 2),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('Get Started', style: textStyle.bodyLarge),
        );
      },
    );
  }
}