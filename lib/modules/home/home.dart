import 'package:flutter/material.dart';
import 'package:tracking/modules/login/login.dart';
import 'package:tracking/modules/signup/Signup.dart';
import 'package:tracking/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset('assets/64665.png', scale: 2.5),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Se',
                    style: TextStyle(
                      fontSize: 41.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'c',
                    style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'urity',
                    style: TextStyle(
                      fontSize: 41.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tr',
                    style: TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'a',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'cking App',
                    style: TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Let\'s make vehicle secure',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              commonButton(
                text: 'Log In',
                function: () {
                  Navigator.pushNamed(context, 'login_screen');
                },
                color: Colors.amber,
                textcolor: Colors.black,
                fontsize: 40.0,
                border: 3.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              commonButton(
                text: 'Sign Up',
                function: () {
                  Navigator.pushNamed(context, 'registration_screen');
                },
                fontsize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
