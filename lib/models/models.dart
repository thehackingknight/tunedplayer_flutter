import 'package:isar/isar.dart';

part 'models.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? name;
  int? age;
}

@collection
class App {
  Id id = Isar.autoIncrement;
  String? name = "TunedPlayer";
  final user = IsarLink<User>();
}
