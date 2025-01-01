import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:flutter_chat_app/provider/user_provider.dart';
import 'package:flutter_chat_app/screens/chat_home_screen.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:flutter_chat_app/widgets/my_button.dart';
import 'package:flutter_chat_app/widgets/my_text_field.dart';
import 'package:flutter_chat_app/widgets/profile_pic_selector.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    final userProvider = context.read<UserProvider>();
    await userProvider.loadUserData();
    final user = userProvider.user;

    if (user != null && !_isInitialized) {
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    final navigator = Navigator.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppbar(
          leadingIcon: Icon(Icons.arrow_back_ios_new_outlined),
          title: 'Your Profile',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 48),
                const ProfilePicSelector(),
                const SizedBox(height: 31),
                MyTextField(
                  label: "First Name (Required)",
                  controller: _firstNameController,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  label: "Last Name (Optional)",
                  controller: _lastNameController,
                ),
                const SizedBox(height: 48),
                MyButton(
                  text: 'Save',
                  onPressed: () async {
                    print('$_firstNameController.text');
                    print('$_lastNameController.text');
                    final userModel = UserModel(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      uid: userProvider.user?.uid ?? '',
                    );
                    await userProvider.saveUserData(userModel);
                    if (mounted) {
                      navigator.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ChatHomeScreen(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
