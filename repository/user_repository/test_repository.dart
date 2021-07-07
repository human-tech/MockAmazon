import 'package:amazon/repository/user_repository.dart';

class TestRepository extends UserRepository {
  final String fakeEmail;
  final bool success;

  const TestRepository(this.fakeEmail, this.success);

  @override
  String get userEmail => fakeEmail;

  @override
  String get username => "Darth Vader";

  @override
  Future<bool> authenticate(String email, String password) {
    return Future<bool>.delayed(const Duration(seconds: 2), () => success);
  }

  @override
  Future<bool> register(String username, String email, String password) async {
    return Future<bool>.delayed(const Duration(seconds: 2), () => success);
  }

  @override
  Future<bool> anonymous() {
    return Future<bool>.delayed(const Duration(seconds: 2), () => success);
  }

  @override
  Future<void> logOut() => Future.delayed(Duration(milliseconds: 50));
}
