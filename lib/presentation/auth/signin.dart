// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:glassmorphism/animation/ui/delayed_animation.dart';
import 'package:glassmorphism/animation/ui/scale_animation.dart';
import 'package:glassmorphism/application/services/api.dart';
import 'package:glassmorphism/domain/commonWidgets/button.dart';
import 'package:glassmorphism/domain/commonWidgets/glassmorphism.dart';
import 'package:glassmorphism/domain/commonWidgets/helpe_navigation_text.dart';
import 'package:glassmorphism/domain/commonWidgets/subtext.dart';
import 'package:glassmorphism/presentation/auth/widgets/textarea.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignIn extends StatelessWidget {
  VoidCallback onTap;
  SignIn({super.key, required this.onTap});

  ValueNotifier<bool> isVisibile = ValueNotifier<bool>(true);
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
                  const SizedBox(height: 80),
                  DelayedAnimation(
                    aniDuration: 900,
                    aniOffsetX: 0.0,
                    aniOffsetY: .60,
                    delayedAnimation: 800,
                    child: welcome(),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: DelayedAnimation(
                      aniDuration: 900,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.35,
                      delayedAnimation: 1000,
                      child: SubText(
                        text: 'login now & Continue your shopping!!!',
                        size: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 230,
                    width: 300,
                  ),
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
                  const SizedBox(height: 5),
                  DelayedAnimation(
                    aniDuration: 500,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: forgotPassword(),
                  ),
                  const SizedBox(height: 25),
                  DelayedAnimation(
                    aniDuration: 500,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: CustomButton(
                      text: 'Login',
                      ontap: () {
                        if (formkey.currentState!.validate()) {
                          Api.signIn(context,
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
                      "SignIn",
                      // onTap: () {
                      //   Navigator.of(context).push(
                      //       MaterialPageRoute(builder: (context) => SignUp()));
                      // },
                      onTap: onTap,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DelayedAnimation(
                    aniDuration: 500,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: socialMediaIcons(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget welcome() {
    return Text(
      'WELCOME',
      style: GoogleFonts.lora(
        fontSize: 43,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 236, 236, 236),
      ),
    );
  }

  TextArea emailTextArea() {
    return TextArea(
        keyboardType: TextInputType.emailAddress,
        name: 'Email',
        prefixIcon: const Icon(
          MdiIcons.emailBox,
        ),
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

  Widget forgotPassword() {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            'Forgot password?',
            style: GoogleFonts.acme(
                fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget socialMediaIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleAnimation(
          delayTime: 800,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purple,
                      Colors.pink,
                      Colors.orange,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                MdiIcons.instagram,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ScaleAnimation(
          delayTime: 800,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                MdiIcons.twitter,
                color: Colors.blue,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ScaleAnimation(
          delayTime: 800,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              clipBehavior: Clip.none,
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                MdiIcons.google,
                color: Colors.green,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ScaleAnimation(
          delayTime: 800,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                MdiIcons.facebook,
                color: Colors.blue,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
