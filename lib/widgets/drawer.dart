import 'package:amazon/repository/user_repository/email_repository.dart';
import 'package:flutter/material.dart';
import 'package:amazon/blocs/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerContents extends StatelessWidget {
  const DrawerContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CustomDrawerHeader(),
          const ListTile(
            title: Text("Home"),
          ),
          const ListTile(
            title: Text("Shop by Category"),
          ),
          const ListTile(
            title: Text("Today's Deals"),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          const ListTile(
            title: Text("Your Orders"),
          ),
          const ListTile(
            title: Text("Buy Again"),
          ),
          const ListTile(
            title: Text("Your Wishlist"),
          ),
          const ListTile(
            title: Text("Your Account"),
          ),
          const ListTile(
            title: Text("Amazon Pay"),
          ),
          const ListTile(
            title: Text("Prime"),
          ),
          const ListTile(
            title: Text("Sell on Amazon"),
          ),
          const ListTile(
            title: Text("Programs and Features"),
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          const ListTile(
            title: Text("Language A/क"),
          ),
          const ListTile(
            title: Text("Your Notifications"),
          ),
          const ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.arrow_forward_ios, size: 15)),
          const ListTile(
            title: Text("Customer Service"),
          ),
          ListTile(
              key: Key("Log Out"),
              title: Text("Log Out"),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              trailing: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = context.read<FirebaseUserRepository>().username;

    return Container(
      height: 80,
      decoration: BoxDecoration(color: const Color(0xFF232f3e)),
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[600],
            child: Icon(Icons.person, size: 30),
            radius: 22,
          ),
          title: Text(
            "Hello, ${username}",
            style: TextStyle(
                fontSize: 22,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
