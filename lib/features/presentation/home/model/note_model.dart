// في note_model.dart
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'note_model.g.dart';
@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title; // بدون final

  @HiveField(2)
  String body; // بدون final

  @HiveField(3)
  int color; // بدون final

  @HiveField(4)
  final DateTime date;

  Note({
    String? id,
    required this.title,
    required this.body,
    required this.color,
    required this.date,
  }) : id = id ?? const Uuid().v4();
}
