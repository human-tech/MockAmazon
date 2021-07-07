import 'package:equatable/equatable.dart';

abstract class CredentialsEvents extends Equatable {
  final String? username;
  final String? email;
  final String? password;

  const CredentialsEvents({this.username, this.email, this.password});

  @override
  List<Object> get props => [email ?? "", password ?? ""];
}

class LoginButtonPressed extends CredentialsEvents {
  const LoginButtonPressed({required String email, required String password})
      : super(email: email, password: password);
}

class RegisterButtonPressed extends CredentialsEvents {
  const RegisterButtonPressed(
      {required String username,
      required String email,
      required String password})
      : super(username: username, email: email, password: password);
}

class AnonymousLoginPressed extends CredentialsEvents {
  const AnonymousLoginPressed();
}
