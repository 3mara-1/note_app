// edit_note_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/home/cubit/note_cubit.dart';
import 'package:note_app/features/presentation/home/cubit/note_state.dart';
import 'package:note_app/features/presentation/home/model/note_model.dart';
import 'package:note_app/features/presentation/home/widgets/chose_color.dart';
import 'package:note_app/features/presentation/auth/widgets/custum_form_field.dart';
import 'package:note_app/features/presentation/home/widgets/custom_text_filed.dart';
import 'package:note_app/vallidator.dart';

class EditNote extends StatefulWidget {
  final Note note;
  
  const EditNote({
    super.key,
    required this.note,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  late Color selectedNoteColor;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    bodyController = TextEditingController(text: widget.note.body);
    selectedNoteColor = Color(widget.note.color);
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => _showEditBottomSheet(context),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 9,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Edit note', style: textStyle.bodyLarge),
                    
                    ColorPickerBar(
                      onColorSelected: (newColor) {
                        setModalState(() {
                          selectedNoteColor = newColor;
                        });
                      },
                    ),
                    
                    CustomFormField(
                      controller: titleController,
                      validator: (value) => MyValidators.namevalidator(value),
                      labelText: 'note title',
                      labelStyle: textStyle.labelMedium,
                      fillColor: colorStyle.primary,
                    ),
                    
                    CustomTextFiled(
                      hintText: 'note body',
                      controller: bodyController,
                      fillColor: colorStyle.primary,
                      hintStyle: textStyle.labelMedium,
                    ),
                    
                    ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        final body = bodyController.text.trim();
                        
                        if (body.isNotEmpty && title.isNotEmpty) {
                          context.read<NoteCubit>().updateNote(
                            note: widget.note,
                            title: title,
                            body: body,
                            color: selectedNoteColor.value,
                          );
                          
                          Navigator.pop(bottomSheetContext);
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Note updated!')),
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
                      child: Text('Update note', style: textStyle.bodyLarge),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}