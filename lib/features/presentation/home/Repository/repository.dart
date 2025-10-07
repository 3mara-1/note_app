import 'package:hive/hive.dart';
import 'package:note_app/features/presentation/home/model/note_model.dart';

class NoteRepository {
  // الحصول على الصندوق الذي تم فتحه في main.dart
  Box<Note> get _noteBox => Hive.box<Note>('notes');

  // جلب كل الملاحظات من الصندوق
  List<Note> getNotes() {
    return _noteBox.values.toList();
  }

  // إضافة ملاحظة جديدة
  Future<void> addNote(Note note) async {
    await _noteBox.add(note);
  }

  // تعديل ملاحظة موجودة
  Future<void> updateNote(Note note) async {
    if (note.isInBox) {
      await note.save();
    }
  }

  // حذف ملاحظة
  Future<void> deleteNote(Note note) async {
    if (note.isInBox) {
      await note.delete();
    }
  }

  // حذف ملاحظة بالـ key
  Future<void> deleteNoteByKey(dynamic key) async {
    await _noteBox.delete(key);
  }

  // الحصول على ملاحظة بالـ ID
  Note? getNoteById(String id) {
    try {
      return _noteBox.values.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  // البحث في الملاحظات
  List<Note> searchNotes(String query) {
    if (query.isEmpty) return getNotes();
    
    return _noteBox.values.where((note) {
      final titleMatch = note.title.toLowerCase().contains(query.toLowerCase());
      final bodyMatch = note.body.toLowerCase().contains(query.toLowerCase());
      return titleMatch || bodyMatch;
    }).toList();
  }

  // ترتيب الملاحظات حسب التاريخ
  List<Note> getNotesSortedByDate({bool ascending = false}) {
    final notes = getNotes();
    notes.sort((a, b) {
      return ascending 
          ? a.date.compareTo(b.date)
          : b.date.compareTo(a.date);
    });
    return notes;
  }

  // الحصول على عدد الملاحظات
  int getNotesCount() {
    return _noteBox.length;
  }

  // حذف كل الملاحظات
  Future<void> deleteAllNotes() async {
    await _noteBox.clear();
  }

  // الحصول على الملاحظات حسب اللون
  List<Note> getNotesByColor(int color) {
    return _noteBox.values.where((note) => note.color == color).toList();
  }

  // الحصول على آخر ملاحظة تم إضافتها
  Note? getLastNote() {
    if (_noteBox.isEmpty) return null;
    final notes = getNotes();
    notes.sort((a, b) => b.date.compareTo(a.date));
    return notes.first;
  }
}