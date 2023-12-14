// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:glassmorphism/domain/commonWidgets/glassmorphism.dart';
import 'package:glassmorphism/presentation/auth/widgets/textarea.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  ValueNotifier<bool> isVisibile = ValueNotifier<bool>(true);
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/background.jpg'),
            ),
          ),
          child: Center(
            child: GlassMorphism(
              blur: 10,
              opacity: 0.3,
              radius: 10,
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  TextArea(
                      keyboardType: TextInputType.emailAddress,
                      name: 'email',
                      prefixIcon: Icon(Icons.email),
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
                      obscureText: false),
                  const SizedBox(height: 40),
                  ListenableBuilder(
                      listenable: isVisibile,
                      builder: (BuildContext context, value) {
                        return TextArea(
                          keyboardType: TextInputType.text,
                          name: 'password',
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
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                          ),
                          obscureText: isVisibile.value,
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
