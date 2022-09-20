import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:module_five/Task3/TaskSharedPreferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Welcome To Home page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text('Welcome to Homepage'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SharedPreferencesTask(),
                    ),
                  );
                },
                child: Text(
                  'Proceed For Login',
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SharedPreferencesTask(),
                    ),
                  );
                },
                child: Text(
                  'LogOut',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
