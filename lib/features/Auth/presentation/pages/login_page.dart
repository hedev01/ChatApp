import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_event.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_state.dart';
import 'package:chat_app/features/Auth/presentation/pages/register_page.dart';
import 'package:chat_app/features/Auth/presentation/widgets/auth_button.dart';
import 'package:chat_app/features/Auth/presentation/widgets/auth_title.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chat_app/global_widget/error_message_widget.dart';
import 'package:chat_app/global_widget/success_message_widget.dart';
import 'package:chat_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../global_widget/app_text_field.dart';
import '../../../../global_widget/password_text_field.dart';
import '../widgets/auth_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailCtr;
  late final TextEditingController passwordCtr;
  @override
  void initState() {
    emailCtr = TextEditingController();
    passwordCtr = TextEditingController();
    super.initState();
  }

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
                  SizedBox(height: size.height * .09),
                  AuthTitle(title: "Login Your\n Account"),
                  SizedBox(height: size.height * .09),
                  AppTextField(
                    hint: "Email",
                    icon: Icons.mail,
                    controller: emailCtr,
                  ),
                  SizedBox(height: size.height * .02),
                  PasswordTextField(passwordCtr: passwordCtr),
                  SizedBox(height: size.height * .02),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) async {
                      if (state.status == LoginStatus.success) {
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
                    },
                    builder: (context, state) {
                      return AuthButton(
                        size: size,
                        onPressed: () {
                          context.read<LoginBloc>().add(
                            LoginSubmitted(
                              email: emailCtr.text,
                              password: passwordCtr.text,
                            ),
                          );
                        },
                        child: state.status == LoginStatus.loading
                            ? CircularProgressIndicator(
                                backgroundColor: AppColors.lightBackground,
                              )
                            : Text("Login"),
                      );
                    },
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      Widget? widget;
                      if (state.status == LoginStatus.success) {
                        widget = SuccessMessageWidget(message: "Login Success");
                      } else if (state.status == LoginStatus.failure) {
                        widget = ErrorMessageWidget(
                          message: state.error ?? "Error",
                        );
                      }
                      return widget ?? SizedBox();
                    },
                  ),
                  SizedBox(height: size.height * .02),
                  AuthFooter(
                    linkText: "Sign Up",
                    onTap: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage();
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
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }
}
