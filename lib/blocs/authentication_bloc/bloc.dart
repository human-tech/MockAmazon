import 'package:amazon/blocs/authentication_bloc/events.dart';
import 'package:amazon/blocs/authentication_bloc/states.dart';
import 'package:amazon/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc(this.userRepository) : super(const AuthenticationInit());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoggedIn) {
      yield const AuthenticationSuccess();
    }
    if (event is LoggedOut) {
      yield const AuthenticationLoading();
      await userRepository.logOut();
      yield const AuthenticationRevoked();
    }
  }
}
