// ملف: note_item.dart (مثال)

import 'package:flutter/material.dart';
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
    return Container(
      padding: const EdgeInsets.all(16),
      // استخدم اللون المحفوظ في الملاحظة كخلفية
      decoration: BoxDecoration(
        color: Color(note.color), // تحويل الـ int المحفوظ إلى Color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),

        border: Border.all(width: 2.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // محتوى الملاحظة
          Expanded(
            child: Text(
              note.body,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.7),
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          Text(note.date.toString()),
          Row(
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
