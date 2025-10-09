// في note_model.dart
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'note_model.g.dart';
@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String body;

  @HiveField(3)
  int color; 

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
