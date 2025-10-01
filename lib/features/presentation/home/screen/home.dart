import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: false,
          title: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.033,
                      backgroundColor: Color(0xff000000),

                      child: CircleAvatar(
                        backgroundImage: state.user.profilPic != null
                            ? FileImage(File(state.user.profilPic!))
                            : null,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: MediaQuery.of(context).size.height * 0.030,
                        child: state.user.profilPic == null
                            ? Icon(
                                Icons.add_photo_alternate_rounded,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: MediaQuery.of(context).size.height * 0.04,
                              )
                            : null,
                      ),
                    ),
                    Text(
                      'Hi, ${state.user.name}',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
