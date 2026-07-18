import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_event.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_state.dart';
import 'package:chat_app/features/Auth/presentation/pages/login_page.dart';
import 'package:chat_app/features/Auth/presentation/widgets/auth_title.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chat_app/global_widget/error_message_widget.dart';
import 'package:chat_app/core/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../global_widget/app_text_field.dart';
import '../../../../global_widget/password_text_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_footer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController userNameCtr;
  late final TextEditingController firstNameCtr;
  late final TextEditingController lastNameCtr;
  late final TextEditingController emailCtr;
  late final TextEditingController passwordCtr;
  @override
  void initState() {
    userNameCtr = TextEditingController();
    firstNameCtr = TextEditingController();
    lastNameCtr = TextEditingController();
    emailCtr = TextEditingController();
    passwordCtr = TextEditingController();
    super.initState();
  }

  final AuthUseCase authUseCase = AuthUseCase(locator.get());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .04),
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (widget) => SlideAnimation(
                  duration: Duration(milliseconds: 600),
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  SizedBox(height: size.height * .06),
                  AuthTitle(title: "Create Your\n Account"),
                  SizedBox(height: size.height * .05),
                  AppTextField(
                    hint: "User Name",
                    icon: Icons.person,
                    controller: userNameCtr,
                  ),
                  SizedBox(height: size.height * .02),
                  AppTextField(
                    hint: "First Name",
                    icon: Icons.person,
                    controller: firstNameCtr,
                  ),
                  SizedBox(height: size.height * .02),
                  AppTextField(
                    hint: "Last Name",
                    icon: Icons.person,
                    controller: lastNameCtr,
                  ),
                  SizedBox(height: size.height * .02),
                  AppTextField(
                    hint: "Email",
                    icon: Icons.mail,
                    controller: emailCtr,
                  ),
                  SizedBox(height: size.height * .02),
                  PasswordTextField(passwordCtr: passwordCtr),
                  SizedBox(height: size.height * .02),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      if (state.status == RegisterStatus.success) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatListPage(
                                userId: state.user!.data!.userId,
                              );
                            },
                          ),
                          (route) => false,
                        );
                      }
                      return AuthButton(
                        size: size,
                        onPressed: () {
                          context.read<RegisterBloc>().add(
                            RegisterSubmitted(
                              username: userNameCtr.text,
                              email: emailCtr.text,
                              password: passwordCtr.text,
                              firstName: firstNameCtr.text,
                              lastName: lastNameCtr.text,
                            ),
                          );
                        },
                        child: state.status == RegisterStatus.loading
                            ? CircularProgressIndicator(
                                backgroundColor: AppColors.lightBackground,
                              )
                            : Text("Register"),
                      );
                    },
                  ),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      if (state.status == RegisterStatus.failure) {
                        return ErrorMessageWidget(
                          message: state.error ?? "Error",
                        );
                      }

                      return SizedBox();
                    },
                  ),
                  SizedBox(height: size.height * .02),
                  AuthFooter(
                    linkText: "Sign Up",
                    onTap: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameCtr.dispose();
    firstNameCtr.dispose();
    lastNameCtr.dispose();
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }
}
