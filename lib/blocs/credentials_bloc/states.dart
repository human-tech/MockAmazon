import 'package:equatable/equatable.dart';

abstract class CredentialsState extends Equatable {
  const CredentialsState();

  @override
  List<Object> get props => [];
}

class CredentialsInitial extends CredentialsState {
  const CredentialsInitial();
}

class CredentialsLoginLoading extends CredentialsState {
  const CredentialsLoginLoading();
}

class CredentialsRegisterLoading extends CredentialsState {
  const CredentialsRegisterLoading();
}

class CredentialsLoginFailure extends CredentialsState {
  const CredentialsLoginFailure();
}

class CredentialsRegisterFailure extends CredentialsState {
  const CredentialsRegisterFailure();
}
