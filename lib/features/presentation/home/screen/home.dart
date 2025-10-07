import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_cubit.dart';
import 'package:note_app/features/presentation/auth/cubit/auth_state.dart';
import 'package:note_app/features/presentation/home/cubit/note_cubit.dart';
import 'package:note_app/features/presentation/home/cubit/note_state.dart'; // ✅ إضافة
import 'package:note_app/features/presentation/home/widgets/add_note_button.dart';
import 'package:note_app/features/presentation/home/widgets/note_Item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 86,
          shape: const RoundedRectangleBorder(
            side: BorderSide(width: 2.5),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
          backgroundColor: colorStyle.primaryContainer.withOpacity(0.7),
          title: BlocBuilder<UserCubit, UserState>(
            // ✅ تصحيح الاسم
            builder: (context, state) {
              // حالة تحميل المستخدم
              if (state is UserLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // حالة نجاح تحميل المستخدم
              if (state is UserLoaded) {
                // ✅ تصحيح الاسم
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
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
                                size: MediaQuery.of(context).size.height * 0.04,
                              )
                            : null,
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

              // حالة فارغة أو خطأ
              return const Text('Guest');
            },
          ),
        ),

        body: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            // --- حالة التحميل ---
            if (state is NoteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // --- حالة النجاح ---
            if (state is NoteLoaded) {
              // ✅ تصحيح الاسم
              // لو لا توجد ملاحظات، اعرض رسالة
              if (state.notes.isEmpty) {
                return Center(
                  child: Text(
                    'No notes yet. Add one!',
                    style: textStyle.bodyLarge,
                  ),
                );
              }

              // لو توجد ملاحظات، اعرض GridView
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  crossAxisSpacing: 16, // المسافة الأفقية
                  mainAxisSpacing: 16, // المسافة الرأسية
                  childAspectRatio: 0.75, // ✅ إضافة نسبة مناسبة
                ),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return NoteItem(note: note);
                },
              );
            }

            // --- حالة الخطأ ---
            if (state is NoteError) {
              // ✅ تصحيح الاسم
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'), // ✅ تصحيح الاسم
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

            // --- الحالة الأولية ---
            return const Center(child: Text('Welcome!'));
          },
        ),

        floatingActionButton: AddNoteButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
