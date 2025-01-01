import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/provider/auth_provider.dart';
import 'package:flutter_chat_app/screens/profile_screen.dart';
import 'package:flutter_chat_app/widgets/login_info_text.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OtpValidationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpValidationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<OtpValidationScreen> createState() => _OtpValidationScreenState();
}

class _OtpValidationScreenState extends State<OtpValidationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  void validateOtp(BuildContext context) async {
    String otp = _controllers.map((controller) => controller.text).join();

    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.verifyOtp(
        widget.verificationId,
        otp,
        () {
          if (mounted) {
            navigator.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Invalid OTP: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppbar(
          leadingIcon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoginInfoText(
                  title: 'Enter Code',
                  subtitle:
                      'We have sent you an SMS with the code to ${widget.phoneNumber}',
                ),
                OtpInputField(
                  controllers: _controllers,
                  onComplete: () => validateOtp(context),
                ),
                const SizedBox(height: 77),
                const ResendLinkText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpInputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onComplete;
  const OtpInputField(
      {super.key, required this.controllers, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) {
          return _otpBox(context, controllers[index], index);
        },
      ),
    );
  }

  Widget _otpBox(
      BuildContext context, TextEditingController controller, int index) {
    return SizedBox(
      height: 58,
      width: 48,
      child: TextFormField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: AppTypography.heading1.copyWith(
          color: AppColors.active,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          counterText: '',
          filled: true,
          fillColor: AppColors.offWhite,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.defaultColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.defaultColor,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.defaultColor,
              width: 1.8,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.danger,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }

          if (_allFieldsFilled()) {
            onComplete();
          }
        },
      ),
    );
  }

  bool _allFieldsFilled() {
    return controllers.every((controllers) => controllers.text.isNotEmpty);
  }
}

class ResendLinkText extends StatelessWidget {
  const ResendLinkText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse('https://github.com/ahammednibras8');

        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
      child: Text(
        'Rensnd Link',
        style: AppTypography.subheading2.copyWith(
          color: AppColors.defaultColor,
        ),
      ),
    );
  }
}
