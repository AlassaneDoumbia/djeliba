import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    splashDelay();
  }

  void splashDelay() async {
    bool skipLogin = false;
    final prefs = await SharedPreferences.getInstance();
    final bool? saveUser = prefs.getBool('saveUser');
    if (saveUser != null) {
      skipLogin = saveUser;
    }
    await Future.delayed(
      const Duration(seconds: 5),
    );

    if (skipLogin) {
      Navigator.pushNamed(
        context,
        '/',
      );
    } else {
      Navigator.pushNamed(
        context,
        '/login',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo_dark.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
      ),
    );
  }
}