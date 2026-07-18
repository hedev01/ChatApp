import 'package:chat_app/features/Auth/presentation/pages/splash_screen.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:chat_app/features/user/domain/entity/user_entity.dart';
import 'package:chat_app/features/user/domain/usecase/delete_user_usecase.dart';
import 'package:chat_app/core/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/presentation/bloc/chat_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final UserDataEntity user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        context.read<ChatBloc>().add(ChatSubmitted(userId: user.userId));
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height / 20,
              horizontal: size.width * .05,
            ),
            child: Column(
              children: [
                // App Bar
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          context.read<ChatBloc>().add(
                            ChatSubmitted(userId: user.userId),
                          );

                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),

                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * .05),

                // Avatar
                Stack(
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color(0xffEEF4FF),
                          backgroundImage: state.avatar != null
                              ? FileImage(state.avatar!)
                              : null,
                          child: state.avatar == null
                              ? Text(
                                  "${user.firstName[0]}${user.lastName[0]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                    color: Color(0xff4F8CFF),
                                  ),
                                )
                              : null,
                        );
                      },
                    ),

                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff4F8CFF),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                              PickAvatarRequested(userId: user.userId),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Name
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Email
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                // Settings
                ProfileMenuItem(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: () {},
                ),

                const SizedBox(height: 15),

                // Logout
                ProfileMenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  color: Colors.red,
                  onTap: () async {
                    DeleteUserUsecase deleteUserUsecase = DeleteUserUsecase(
                      locator.get(),
                    );
                    await deleteUserUsecase();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SplashScreen();
                        },
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade100,
        ),

        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.black),

            const SizedBox(width: 15),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
