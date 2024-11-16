import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/widgets/login_info_text.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        appBar: MyAppbar(
          leadingIcon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginInfoText(
                title: "Enter Your Phone Number",
                subtitle:
                    "Please confirm your country code and enter your phone number",
              ),
              SizedBox(height: 48),
              PhoneInputText()
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneInputText extends StatelessWidget {
  const PhoneInputText({super.key});

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
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.defaultColor,
            width: 1.8,
          ),
        ),
      ),
      initialCountryCode: 'IN',
    );
  }
}
