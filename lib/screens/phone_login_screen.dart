import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/provider/auth_provider.dart';
import 'package:flutter_chat_app/screens/otp_validation_screen.dart';
import 'package:flutter_chat_app/widgets/login_info_text.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:flutter_chat_app/widgets/my_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppbar(
          leadingIcon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const LoginInfoText(
                title: "Enter Your Phone Number",
                subtitle:
                    "Please confirm your country code and enter your phone number",
              ),
              const SizedBox(height: 48),
              PhoneInputText(
                onPhoneNumberChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              const SizedBox(height: 81),
              MyButton(
                text: authProvider.isLoading ? 'Sending OTP' : 'Continue',
                onPressed: () async {
                  if (phoneNumber.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please Enter a Number"),
                      ),
                    );
                  }

                  try {
                    await authProvider.sendOtp(
                      phoneNumber,
                      (verificationId) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpValidationScreen(
                              phoneNumber: phoneNumber,
                              verificationId: verificationId,
                            ),
                          ),
                        );
                      },
                    );
                  } catch (e) {
                    debugPrint('$e');
                    if (mounted) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneInputText extends StatelessWidget {
  final ValueChanged<String> onPhoneNumberChanged;
  const PhoneInputText({super.key, required this.onPhoneNumberChanged});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.offWhite,
        labelText: 'Phone Number',
        counterText: '',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: AppTypography.body1.copyWith(
          color: AppColors.disabled,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.defaultColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.defaultColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.danger,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.defaultColor,
            width: 1.8,
          ),
        ),
      ),
      initialCountryCode: 'IN',
      onChanged: (phone) {
        onPhoneNumberChanged(phone.completeNumber);
      },
    );
  }
}
