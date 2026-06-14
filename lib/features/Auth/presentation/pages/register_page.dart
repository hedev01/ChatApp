import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../global_widget/app_text_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_footer.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  Text(
                    "Create Your\n Account",
                    style: TextStyle(fontSize: 35, color: Color(0xff323142)),
                  ),
                  SizedBox(height: size.height * .05),
                  const AppTextField(hint: "User Name", icon: Icons.person),
                  SizedBox(height: size.height * .02),
                  const AppTextField(hint: "First Name", icon: Icons.person),
                  SizedBox(height: size.height * .02),
                  const AppTextField(hint: "Last Name", icon: Icons.person),
                  SizedBox(height: size.height * .02),
                  const AppTextField(hint: "Email", icon: Icons.mail),
                  SizedBox(height: size.height * .02),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, size: 25),
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: size.height * .02),
                  AuthButton(size: size),
                  SizedBox(height: size.height * .02),
                  AuthFooter(onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
