abstract class UserRepository {
  const UserRepository();

  String get userEmail;

  String get username;

  Future<bool> authenticate(String email, String password);

  Future<bool> register(String username, String email, String password);

  Future<void> logOut();
}
