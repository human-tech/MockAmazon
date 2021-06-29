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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void loginTransition() {
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
