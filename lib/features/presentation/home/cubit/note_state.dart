import 'package:note_app/features/presentation/home/model/note_model.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;
  NoteLoaded(this.notes);
}

class NoteError extends NoteState {
  final String message;
  NoteError(this.message);
}

class NoteOperationSuccess extends NoteState {
  final String message;
  NoteOperationSuccess(this.message);
}