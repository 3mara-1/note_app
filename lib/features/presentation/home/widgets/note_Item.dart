// ملف: note_item.dart (مثال)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/home/cubit/note_cubit.dart';
import 'package:note_app/features/presentation/home/model/note_model.dart';
import 'package:note_app/features/presentation/home/widgets/delete_note.dart';
import 'package:note_app/features/presentation/home/widgets/edit_note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(note.color), // تحويل الـ int المحفوظ إلى Color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),

        border: Border.all(width: 2.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: textStyle.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // محتوى الملاحظة
          Text(
            note.body,
            style: textStyle.bodyMedium,
            overflow: TextOverflow.fade,
          ),

          Text(
            DateFormat('hh:mm a').format(note.date),
            style: textStyle.bodySmall,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              EditNote(note: note),
              Spacer(),
              DeleteNote(note: note),
            ],
          ),
        ],
      ),
    );
  }
}
