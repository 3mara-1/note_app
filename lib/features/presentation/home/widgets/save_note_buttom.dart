// save_note_buttom.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/home/cubit/note_cubit.dart';
import 'package:note_app/features/presentation/home/cubit/note_state.dart';

class SaveNoteButtom extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final int color;
  
  const SaveNoteButtom({
    super.key,
    required this.titleController,
    required this.bodyController,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;

    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteLoaded) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note added successfully!')),
          );
        } else if (state is NoteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is NoteLoading;
        
        return ElevatedButton(
          onPressed: isLoading ? null : () {
            // اقرأ القيم عند الضغط
            final title = titleController.text.trim();
            final body = bodyController.text.trim();
            
            if (body.isNotEmpty && title.isNotEmpty) {
              context.read<NoteCubit>().addNote(
                title: title,
                body: body,
                color: color,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all fields')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorStyle.primaryContainer,
            minimumSize: const Size(320, 60),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
              side: const BorderSide(width: 2.5),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('Add note', style: textStyle.bodyLarge),
        );
      },
    );
  }
}