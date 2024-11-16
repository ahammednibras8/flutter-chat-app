import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppbar(
        leadingIcon: Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: Center(
        child: Text('Phone Login Screen'),
      ),
    );
  }
}
