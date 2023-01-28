import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_colors.dart';
import 'package:my_amazon/widgets/base/custom_button.dart';
import 'package:my_amazon/widgets/base/custom_textfield.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              tileColor: _auth == Auth.signUp
                  ? AppColors.backgroundColor
                  : AppColors.greyBackgroundCOlor,
              title: const Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: AppColors.secondaryColor,
                value: Auth.signUp,
                groupValue: _auth,
                onChanged: (value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signUp)
              Container(
                padding: const EdgeInsets.all(8),
                color: AppColors.backgroundColor,
                child: Form(
                    key: signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextfield(
                          controller: emailController,
                          hintText: "Email",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: nameController,
                          hintText: "Name",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: passwordController,
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(onTap: () {}, buttonText: "Sign Up")
                      ],
                    )),
              ),
            ListTile(
              tileColor: _auth == Auth.signIn
                  ? AppColors.backgroundColor
                  : AppColors.greyBackgroundCOlor,
              title: const Text(
                "Sign In",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: AppColors.secondaryColor,
                value: Auth.signIn,
                groupValue: _auth,
                onChanged: (value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signIn)
              Container(
                padding: const EdgeInsets.all(8),
                color: AppColors.backgroundColor,
                child: Form(
                    key: signInFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextfield(
                          controller: emailController,
                          hintText: "Email",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextfield(
                          controller: passwordController,
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(onTap: () {}, buttonText: "Sign In")
                      ],
                    )),
              ),
          ],
        ),
      )),
    );
  }
}
