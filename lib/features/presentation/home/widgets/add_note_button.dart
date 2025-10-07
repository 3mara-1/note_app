import 'package:flutter/material.dart';
import 'package:note_app/features/presentation/auth/widgets/custum_form_field.dart';
import 'package:note_app/features/presentation/home/widgets/chose_color.dart';
import 'package:note_app/features/presentation/home/widgets/custom_text_filed.dart';
import 'package:note_app/features/presentation/home/widgets/save_note_buttom.dart';
import 'package:note_app/vallidator.dart';

class AddNoteButton extends StatefulWidget {
  const AddNoteButton({super.key});

  @override
  State<AddNoteButton> createState() => _AddNoteButtonState();
}

class _AddNoteButtonState extends State<AddNoteButton> {
  Color selectedNoteColor = noteColors[0];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;

    return FloatingActionButton(
      backgroundColor: colorStyle.primaryContainer,
      onPressed: () {
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 9,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Add new note', style: textStyle.bodyLarge),
                          ColorPickerBar(
                            onColorSelected: (newColor) {
                              setModalState(() {
                                selectedNoteColor = newColor;
                              });
                            },
                          ),
                          CustomFormField(
                            controller: titleController,
                            validator: null,
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

                          SaveNoteButtom(
                            titleController: titleController,
                            bodyController: bodyController,
                            color: selectedNoteColor.value,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ).then((_) {
          titleController.clear();
          bodyController.clear();
          setState(() {
            selectedNoteColor = noteColors[0];
          });
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
