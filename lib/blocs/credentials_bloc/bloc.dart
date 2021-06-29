import 'package:amazon/blocs/authentication_bloc.dart';
import 'package:amazon/blocs/credentials_bloc/events.dart';
import 'package:amazon/blocs/credentials_bloc/states.dart';
import 'package:amazon/repository/user_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CredentialsBloc extends Bloc<CredentialsEvents, CredentialsState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  CredentialsBloc(
      {required this.authenticationBloc, required this.userRepository})
      : super(const CredentialsInitial());

  @override
  Stream<CredentialsState> mapEventToState(CredentialsEvents event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginPressed(event);
    }
    if (event is RegisterButtonPressed) {
      yield* _registerPressed(event);
    }
  }

  Stream<CredentialsState> _loginPressed(CredentialsEvents event) async* {
    yield const CredentialsLoginLoading();

    try {
      await userRepository.authenticate(event.email, event.password);

      authenticationBloc.add(LoggedIn());
      yield const CredentialsInitial();
    } on PlatformException {
      yield const CredentialsLoginFailure();
    }
  }

  Stream<CredentialsState> _registerPressed(CredentialsEvents event) async* {
    yield const CredentialsRegisterLoading();

    try {
      final registerState = await userRepository.register(
          event.username ?? "", event.email, event.password);

      if (registerState == true) {
        authenticationBloc.add(LoggedIn());
        yield const CredentialsInitial();
      } else {
        yield const CredentialsRegisterFailure();
      }
    } on PlatformException {
      yield const CredentialsRegisterFailure();
    }
  }
}
