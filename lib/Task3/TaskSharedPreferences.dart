import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:module_five/Task3/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTask extends StatefulWidget {
  const SharedPreferencesTask({Key? key}) : super(key: key);

  @override
  State<SharedPreferencesTask> createState() => _SharedPreferencesState();
}

class _SharedPreferencesState extends State<SharedPreferencesTask> {
  SharedPreferences? prefs;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var loginMessage;
  var saveMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task-3-Shared Preferences'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(labelText: 'Enter UserName'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter user name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Enter Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter password';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            checkLogin();
                            // if (checkLogin == true) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => WelcomeScreen(),
                            //     ),
                            //   );
                            // }
                          }
                        },
                        child: Text('Login')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        save();
                      },
                      child: Text(
                        'Save Data',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text('Login Status = $loginMessage'),
                Text('Save Message = $saveMessage'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      if (_userNameController.text.toString().isNotEmpty &&
          _passwordController.text.toString().isNotEmpty) {
        prefs?.setString(
          '${_userNameController.text.toString()}',
          _passwordController.text.toString(),
        );
        saveMessage = 'Data Saved';
        print('Data saved');
      }
    });
  }

  Future<void> checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    var myValue = prefs!.getString('${_userNameController.text.toString()}');
    setState(() {
      if (myValue.toString() == _passwordController.text.toString()) {
        //print('Login Successfull');
        //
        loginMessage = 'Login Successfull';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      } else {
        loginMessage = 'Error in Login';
      }
    });
  }
}
