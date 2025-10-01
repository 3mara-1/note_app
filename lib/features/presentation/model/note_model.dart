import 'package:hive/hive.dart';

part 'note_model.g.dart';
@HiveType(typeId: 0)
class Note extends HiveObject{
  @HiveField(0)
  final String titel;
  @HiveField(1)
  final String descrption;
  @HiveField(2)
  final String color;
  @HiveField(3)
  final String date;
  Note(this.titel,this.descrption,this.color,this.date);
}