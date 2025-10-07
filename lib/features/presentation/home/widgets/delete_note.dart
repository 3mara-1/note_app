import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/features/presentation/home/cubit/note_cubit.dart';
import 'package:note_app/features/presentation/home/cubit/note_state.dart';
import 'package:note_app/features/presentation/home/model/note_model.dart';

class DeleteNote extends StatelessWidget {
  final Note note;

  const DeleteNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.black,
      onPressed: () => _showDeleteDialog(context),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final colorStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colorStyle.primary,
        title: Text('Delete Note', style: textStyle.bodyLarge),
        content: Text(
          'Are you sure you want to delete this note?',
          style: textStyle.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(dialogContext),
            child: Text('Cancel', style: textStyle.labelMedium),
          ),
          BlocConsumer<NoteCubit, NoteState>(
            listener: (context, state) {
              if (state is NoteLoaded) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Note deleted successfully!',
                      style: textStyle.bodyMedium,
                    ),
                  ),
                );
              } else if (state is NoteError) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final isLoading = state is NoteLoading;

              return TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<NoteCubit>().deleteNote(note);
                      },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Delete', style: textStyle.labelMedium),
              );
            },
          ),
        ],
      ),
    );
  }
}
