import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/screens/phone_login_screen.dart';
import 'package:flutter_chat_app/widgets/my_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset('assets/images/welcome.png'),
              ),
              const SizedBox(height: 42),
              Text(
                'Connect easily with your family and friends over countries',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.active,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 126),
              GestureDetector(
                onTap: () async {
                  final Uri url =
                      Uri.parse('https://github.com/ahammednibras8');

                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Text(
                  'Terms & Privacy Policy',
                  style: AppTypography.body1.copyWith(
                    color: AppColors.active,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              MyButton(
                text: 'Start Messaging',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneLoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
