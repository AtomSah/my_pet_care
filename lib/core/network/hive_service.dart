import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_care/app/constants/hive_table_constant.dart';
import 'package:pet_care/features/auth/data/model/user_hive_model.dart';

class HiveService {
  Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}pet_care.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  // User Queries
  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    return users;
  }

  Future<void> deleteUser(String userId) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(userId);
  }

  // Login using username and password
  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    try {
      // Find the user by email
      UserHiveModel? user = box.values.cast<UserHiveModel?>().firstWhere(
            (element) => element?.email == email,
            orElse: () => null,
          );

      if (user == null || user.password != password) {
        throw Exception("Invalid credentials");
      }

      return user;
    } catch (e) {
      throw Exception("Invalid credentials");
    } finally {
      await box.close();
    }
  }
}
