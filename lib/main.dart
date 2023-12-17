import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/application/provider/provider_bottom.dart';
import 'package:glassmorphism/firebase_options.dart';
import 'package:glassmorphism/presentation/auth/signin.dart';
import 'package:glassmorphism/presentation/auth/signup.dart';
import 'package:glassmorphism/presentation/bottomnavigation/main_home.dart';
import 'package:glassmorphism/presentation/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderBottomNavigation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          tabBarTheme: TabBarTheme(
            labelColor: Colors.pink[800],
            labelStyle: TextStyle(color: Colors.pink[800]), // color for text
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: SignIn(),
        home: const SplashScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error detected'));
            } else if (snapshot.hasData) {
              return MainHome();
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? SignIn(onTap: toggle)
        : SignUp(
            onTap: toggle,
          );
  }

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
