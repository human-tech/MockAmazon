import 'package:amazon/repository/user_repository/email_repository.dart';
import 'package:flutter/material.dart';
import 'package:amazon/blocs/authentication_bloc.dart';
import 'package:amazon/blocs/credentials_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository =
        context.select((FirebaseUserRepository repository) => repository);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: BlocProvider(
        create: (_) => CredentialsBloc(
            userRepository: repository, authenticationBloc: authBloc),
        child: const AuthForm(),
      ),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: const _AuthForm(),
      ),
    );
  }
}

class _AuthForm extends StatefulWidget {
  const _AuthForm({Key? key}) : super(key: key);

  @override
  __AuthFormState createState() => __AuthFormState();
}

class __AuthFormState extends State<_AuthForm> {
  static final _formkey = GlobalKey<FormState>();
  static final _formkeyusername = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _loginButtonPressed(BuildContext context) {
    BlocProvider.of<CredentialsBloc>(context).add(LoginButtonPressed(
        email: emailController.text, password: passwordController.text));
  }

  void _registerButtonPressed(BuildContext context) {
    BlocProvider.of<CredentialsBloc>(context).add(RegisterButtonPressed(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double baseWidth = MediaQuery.of(context).size.width - 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/amazon-logo.svg',
          width: baseWidth,
        ),
        Form(
            key: _formkeyusername,
            child: Wrap(children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: baseWidth - 30,
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      icon: const Icon(Icons.person), hintText: "Username"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Field Cannot be Empty";
                    } else {
                      return null;
                    }
                  },
                ),
              )
            ])),
        Form(
          key: _formkey,
          child: Wrap(
            children: [
              SizedBox(
                width: baseWidth - 30,
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email), hintText: "Email"),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Field Cannot be Empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                width: baseWidth - 30,
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key), hintText: "Password"),
                  validator: (value) {
                    if ((value?.length ?? 0) < 8) {
                      return "Password must contain atleast 8 characters";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<CredentialsBloc, CredentialsState>(
          listener: (context, state) {
            if (state is CredentialsLoginFailure) {
              _showSnackBar(context, "Login Failed!");
            }
          },
          builder: (context, state) {
            if (state is CredentialsLoginLoading) {
              return ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2.0,
                    ),
                    height: 15,
                    width: 15,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellow[500],
                      fixedSize: Size(baseWidth, 30)));
            }

            return ElevatedButton(
                child: const Text(
                  "Already a customer? Sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  final state = _formkey.currentState;

                  if (state?.validate() ?? false) {
                    _loginButtonPressed(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[500],
                    fixedSize: Size(baseWidth, 30)));
          },
        ),
        BlocConsumer<CredentialsBloc, CredentialsState>(
          listener: (context, state) {
            if (state is CredentialsRegisterFailure) {
              _showSnackBar(context, "Registration Failed!");
            }
          },
          builder: (context, state) {
            if (state is CredentialsRegisterLoading) {
              return ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2.0,
                    ),
                    height: 15,
                    width: 15,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey[300],
                      fixedSize: Size(baseWidth, 30)));
            }

            return ElevatedButton(
                child: const Text(
                  "New to Amazon.in? Create an account",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  final _loginStateValidation =
                      _formkey.currentState?.validate();
                  final _registerStateValidation =
                      _formkeyusername.currentState?.validate();

                  if ((_loginStateValidation ?? false) &&
                      (_registerStateValidation ?? false)) {
                    _registerButtonPressed(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300], fixedSize: Size(baseWidth, 30)));
          },
        )
      ],
    );
  }
}
