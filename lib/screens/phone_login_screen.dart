import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/login_info_text.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: LoginInfoText(
                title: "Enter Your Phone Number",
                subtitle:
                    "Please confirm your country code and enter your phone number",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
