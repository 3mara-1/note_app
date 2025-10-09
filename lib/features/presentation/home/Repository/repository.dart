import 'package:hive/hive.dart';
import 'package:note_app/features/presentation/home/model/note_model.dart';

class NoteRepository {
  Box<Note> get _noteBox => Hive.box<Note>('notes');

  List<Note> getNotes() {
    return _noteBox.values.toList();
  }

  Future<void> addNote(Note note) async {
    await _noteBox.add(note);
  }

  Future<void> updateNote(Note note) async {
    if (note.isInBox) {
      await note.save();
    }
  }

  Future<void> deleteNote(Note note) async {
    if (note.isInBox) {
      await note.delete();
    }
  }

  Future<void> deleteNoteByKey(dynamic key) async {
    await _noteBox.delete(key);
  }

  Note? getNoteById(String id) {
    try {
      return _noteBox.values.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Note> searchNotes(String query) {
    if (query.isEmpty) return getNotes();
    
    return _noteBox.values.where((note) {
      final titleMatch = note.title.toLowerCase().contains(query.toLowerCase());
      final bodyMatch = note.body.toLowerCase().contains(query.toLowerCase());
      return titleMatch || bodyMatch;
    }).toList();
  }

  List<Note> getNotesSortedByDate({bool ascending = false}) {
    final notes = getNotes();
    notes.sort((a, b) {
      return ascending 
          ? a.date.compareTo(b.date)
          : b.date.compareTo(a.date);
    });
    return notes;
  }

  int getNotesCount() {
    return _noteBox.length;
  }

  Future<void> deleteAllNotes() async {
    await _noteBox.clear();
  }

  List<Note> getNotesByColor(int color) {
    return _noteBox.values.where((note) => note.color == color).toList();
  }

  Note? getLastNote() {
    if (_noteBox.isEmpty) return null;
    final notes = getNotes();
    notes.sort((a, b) => b.date.compareTo(a.date));
    return notes.first;
  }
}