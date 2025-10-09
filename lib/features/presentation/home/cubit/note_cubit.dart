import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/home/Repository/repository.dart';
import 'package:note_app/features/presentation/home/model/note_model.dart';
import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository _repository;

  NoteCubit(this._repository) : super(NoteInitial());

  void loadNotes() {
    try {
      emit(NoteLoading());
      final notes = _repository.getNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError(' loading failure ${e.toString()}'));
    }
  }

  Future<void> addNote({
    required String title,
    required String body,
    required int color,
  }) async {
    try {
      final note = Note(
        title: title,
        body: body,
        color: color,
        date: DateTime.now(),
      );

      await _repository.addNote(note);
      
      loadNotes();
    } catch (e) {
      emit(NoteError('Add note failure ${e.toString()}'));
    }
  }

Future<void> updateNote({
  required Note note,
  String? title,
  String? body,
  int? color,
}) async {
  try {
    if (note.isInBox) {
      note.title = title ?? note.title;
      note.body = body ?? note.body;
      note.color = color ?? note.color;
      
      await note.save();
      
      loadNotes();
    } else {
      emit(NoteError('Note not found in database'));
    }
  } catch (e) {
    emit(NoteError('reloding note failure ${e.toString()}'));
  }
}
  // حذف ملاحظة
  Future<void> deleteNote(Note note) async {
    try {
      await _repository.deleteNote(note);
      
      // إعادة تحميل الملاحظات
      loadNotes();
    } catch (e) {
      emit(NoteError('remove note failure ${e.toString()}'));
    }
  }

  // البحث في الملاحظات
  void searchNotes(String query) {
    try {
      if (query.isEmpty) {
        loadNotes();
        return;
      }

      final allNotes = _repository.getNotes();
      final filteredNotes = allNotes.where((note) {
        final titleMatch = note.title.toLowerCase().contains(query.toLowerCase());
        final bodyMatch = note.body.toLowerCase().contains(query.toLowerCase());
        return titleMatch || bodyMatch;
      }).toList();

      emit(NoteLoaded(filteredNotes));
    } catch (e) {
      emit(NoteError('Search failed ${e.toString()}'));
    }
  }

  void sortNotesByDate({bool ascending = false}) {
    try {
      final notes = _repository.getNotes();
      notes.sort((a, b) {
        return ascending 
            ? a.date.compareTo(b.date)
            : b.date.compareTo(a.date);
      });
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError('Arrangement failed: ${e.toString()}'));
    }
  }

  Note? getNoteById(String id) {
    final notes = _repository.getNotes();
    try {
      return notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }
}