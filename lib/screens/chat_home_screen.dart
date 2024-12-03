import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/model/chat_model.dart';
import 'package:flutter_chat_app/providers/chat_provider.dart';
import 'package:flutter_chat_app/providers/user_provider.dart';
import 'package:flutter_chat_app/screens/accounts_screen.dart';
import 'package:flutter_chat_app/screens/contacts_screen.dart';
import 'package:flutter_chat_app/screens/phone_login_screen.dart';
import 'package:flutter_chat_app/screens/settings_screen.dart';
import 'package:flutter_chat_app/widgets/chat_widget.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:flutter_chat_app/widgets/my_bottom_navigation.dart';
import 'package:flutter_chat_app/widgets/my_button.dart';
import 'package:flutter_chat_app/widgets/my_text_field.dart';
import 'package:flutter_chat_app/widgets/story_widget.dart';
import 'package:provider/provider.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  int _currentIndex = 1;

  final List<Widget> _screens = const [
    ContactsScreen(),
    ChatMainScreen(),
    AccountsScreen(),
  ];

  void onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: MyBottomNavigation(
          currentIndex: _currentIndex,
          onTap: onNavigationTap,
        ),
      ),
    );
  }
}

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final chatProvider = context.watch<ChatProvider>();

    return Scaffold(
      appBar: MyAppbar(
        title: 'Chats',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.person_add_alt_1_outlined,
              color: AppColors.active,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.active,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const StoryWidget(),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.disabled,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                MyTextField(
                  label: 'Search...',
                  controller: _searchController,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (chatProvider.error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(chatProvider.error!,
                  style: AppTypography.body1.copyWith(
                    color: AppColors.danger,
                  )),
            ),
          Expanded(
            child: StreamBuilder<List<ChatModel>>(
              stream: context.read<ChatProvider>().getChats(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.danger,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text('Error: ${snapshot.error}'),
                        const SizedBox(height: 16),
                        MyButton(
                          text: 'Retry',
                          onPressed: () {
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final chats = snapshot.data!;
                if (chats.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          size: 48,
                          color: AppColors.disabled,
                        ),
                        const SizedBox(height: 16),
                        const Text('No Chats yet'),
                        MyButton(
                          text: 'Start a conversation',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ContactsScreen(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                }

                final filteredChats = chats.where((chat) {
                  if (_searchQuery.isEmpty) return true;

                  if (chat.lastMessage.toLowerCase().contains(_searchQuery)) {
                    return true;
                  }

                  if (chat.participants
                      .any((id) => id.toLowerCase().contains(_searchQuery))) {
                    return true;
                  }

                  if (chat.isGroup &&
                      chat.groupName?.toLowerCase().contains(_searchQuery) ==
                          true) {
                    return true;
                  }

                  return false;
                }).toList();

                if (filteredChats.isEmpty) {
                  return const Center(
                    child: Text('No matching chats found.'),
                  );
                }

                return ListView.builder(
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];
                    return ChatWidget(
                      chat: chat,
                      currentUserId: user!.uid,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
