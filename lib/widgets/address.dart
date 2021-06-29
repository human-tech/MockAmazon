import 'package:amazon/repository/user_repository/email_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final username = context.read<FirebaseUserRepository>().username;

    return ListTile(
      tileColor: const Color(0xFF131921),
      horizontalTitleGap: 2.0,
      leading: const Icon(Icons.location_on, color: Colors.white),
      title: Text(
        "Deliver to ${username} - Death Star 000000",
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Colors.white,
      ),
    );
  }
}
