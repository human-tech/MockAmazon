import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amazon/blocs/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amazon/routes/home.dart';
import 'package:amazon/routes/auth.dart';

class InitNavigator extends StatefulWidget {
  const InitNavigator({Key? key}) : super(key: key);

  @override
  _InitNavigatorState createState() => _InitNavigatorState();
}

class _InitNavigatorState extends State<InitNavigator>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final int initialTab;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      initialTab = 1;
    } else {
      initialTab = 0;
    }

    tabController =
        TabController(length: 2, vsync: this, initialIndex: initialTab);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void loginTransition() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (tabController.index != 1) {
      tabController.animateTo(1);
    }
  }

  void logoutTransition() {
    if (tabController.index != 0) {
      tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          loginTransition();
        }

        if (state is AuthenticationRevoked) {
          logoutTransition();
        }

        return TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [const AuthPage(), const HomePage()],
        );
      },
    );
  }
}
