import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_state.dart';
import 'package:note_app/features/presentation/home/cubit/note_cubit.dart';
import 'package:note_app/features/presentation/home/cubit/note_state.dart'; // ✅ إضافة
import 'package:note_app/features/presentation/home/widgets/add_note_button.dart';
import 'package:note_app/features/presentation/home/widgets/custom_drawer.dart';
import 'package:note_app/features/presentation/home/widgets/note_Item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        drawer: ProfileDrawer(),
        appBar: AppBar(
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
            side: BorderSide(width: 2.5),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          automaticallyImplyLeading: false, 
          backgroundColor: colorStyle.primaryContainer,
          title: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is UserLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.032,
                        backgroundColor: const Color.fromARGB(255, 255, 94, 0),
                        child: CircleAvatar(
                          backgroundImage: state.user.profilPic != null
                              ? FileImage(File(state.user.profilPic!))
                              : null,
                          backgroundColor: colorStyle.primary,
                          radius: MediaQuery.of(context).size.height * 0.027,
                          child: state.user.profilPic == null
                              ? Icon(
                                  Icons.person,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  size:
                                      MediaQuery.of(context).size.height * 0.04,
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Hi, ${state.user.name}',
                      style: textStyle.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }

              return const Text('Guest');
            },
          ),
        ),

        body: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NoteLoaded) {
              if (state.notes.isEmpty) {
                return Center(
                  child: Text(
                    'No notes yet. Add one!',
                    style: textStyle.bodyLarge,
                  ),
                );
              }

              return MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                padding: const EdgeInsets.all(16),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return NoteItem(note: note);
                },
              );
            }

            if (state is NoteError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<NoteCubit>().loadNotes();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Welcome!'));
          },
        ),

        floatingActionButton: AddNoteButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
