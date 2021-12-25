import 'package:hive/hive.dart';
part 'login_model.g.dart';

@HiveType(typeId: 0)
class LoginDetails extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String password;

  LoginDetails(this.name, this.password);
}
