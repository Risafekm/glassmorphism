// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:glassmorphism/animation/ui/delayed_animation.dart';
import 'package:glassmorphism/application/services/api.dart';
import 'package:glassmorphism/domain/commonWidgets/button.dart';
import 'package:glassmorphism/domain/commonWidgets/glassmorphism.dart';
import 'package:glassmorphism/domain/commonWidgets/helpe_navigation_text.dart';
import 'package:glassmorphism/domain/commonWidgets/subtext.dart';
import 'package:glassmorphism/presentation/auth/widgets/textarea.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  VoidCallback onTap;
  SignUp({super.key, required this.onTap});

  ValueNotifier<bool> isVisibile = ValueNotifier<bool>(true);
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background1.jpg'),
          ),
        ),
        child: GlassMorphism(
          blur: 4,
          opacity: 0,
          radius: 10,
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  DelayedAnimation(
                    aniDuration: 900,
                    aniOffsetX: 0.0,
                    aniOffsetY: .60,
                    delayedAnimation: 800,
                    child: signUp(),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: DelayedAnimation(
                      aniDuration: 900,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.35,
                      delayedAnimation: 1000,
                      child: SubText(
                        text: 'Create a new account & Continue your shopping',
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                    width: 300,
                  ),
                  DelayedAnimation(
                    aniDuration: 800,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: userTextArea(),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    aniDuration: 800,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: emailTextArea(),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    aniDuration: 800,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: passTextArea(),
                  ),
                  const SizedBox(height: 40),
                  DelayedAnimation(
                    aniDuration: 500,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: CustomButton(
                      text: 'SignUp',
                      ontap: () {
                        if (formkey.currentState!.validate()) {
                          Api.signUp(context,
                              email: emailController.text.trim(),
                              password: passController.text.trim());
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  DelayedAnimation(
                    aniDuration: 500,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: HelperNavigationText(
                      "SignIn", "You have an account? ",
                      // onTap: () {
                      //   Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (context) => SignIn()));
                      // },
                      onTap: onTap,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signUp() {
    return Text(
      'SIGNUP',
      style: GoogleFonts.lora(
        fontSize: 43,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 236, 236, 236),
      ),
    );
  }

  TextArea userTextArea() {
    return TextArea(
        keyboardType: TextInputType.emailAddress,
        name: 'Username',
        prefixIcon: const Icon(Icons.person),
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'please enter username';
          } else {
            return null;
          }
        },
        suffixIcon: const Icon(
          Icons.abc,
          color: Colors.transparent,
        ),
        obscureText: false);
  }

  TextArea emailTextArea() {
    return TextArea(
        keyboardType: TextInputType.emailAddress,
        name: 'Email',
        prefixIcon: const Icon(Icons.email),
        controller: emailController,
        validator: (value) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!);
          if (value.isEmpty) {
            return 'please enter email';
          } else if (!emailValid) {
            return 'enter valid email';
          } else {
            return null;
          }
        },
        suffixIcon: const Icon(
          Icons.abc,
          color: Colors.transparent,
        ),
        obscureText: false);
  }

  ListenableBuilder passTextArea() {
    return ListenableBuilder(
        listenable: isVisibile,
        builder: (BuildContext context, value) {
          return TextArea(
            keyboardType: TextInputType.text,
            name: 'Password',
            prefixIcon: const Icon(Icons.lock),
            controller: passController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please enter password';
              } else if (value.length < 6) {
                return "weak password";
              } else {
                return null;
              }
            },
            suffixIcon: GestureDetector(
              onTap: () {
                isVisibile.value = !isVisibile.value;
              },
              child: isVisibile.value
                  ? const Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
            ),
            obscureText: isVisibile.value,
          );
        });
  }
}
