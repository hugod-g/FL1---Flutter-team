import 'package:flutter/material.dart';
import 'package:front_end_flutter/Components/button.dart';
import 'package:front_end_flutter/Components/text_input.dart';
import 'package:front_end_flutter/Page/register.dart';
import 'package:front_end_flutter/Services/api/auth.dart';
import '../Style/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String email = "";
  String password = "";
  String? error;
  bool isLoading = false;

  void _onConnectPress() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final int responseStatus = await loginCall(email, password);

      if (responseStatus == 200) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const RegisterPage(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onEmailChange(String newValue) {
    setState(() {
      email = newValue;
    });
  }

  void _onPasswordChange(String newValue) {
    setState(() {
      password = newValue;
    });
  }

  void _onSignUpPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: blueclaire,
      child: SafeArea(
        child: Container(
          color: blueclaire,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Mon Petit",
                      style: TextStyle(
                        color: grisfoncer,
                        fontSize: 30,
                        fontFamily: "regular",
                      ),
                    ),
                    Text(
                      "Garage",
                      style: TextStyle(
                        color: grisfoncer,
                        fontSize: 50,
                        fontFamily: "bold",
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: grisfoncer,
                      fontSize: 16,
                      fontFamily: "regular",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextInput(
                      value: email,
                      placeholder: "Adresse E-mail",
                      onChangeText: _onEmailChange,
                    ),
                  ),
                  const Text(
                    "Mot de passe",
                    style: TextStyle(
                      color: grisfoncer,
                      fontSize: 16,
                      fontFamily: "regulat",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextInput(
                      value: password,
                      placeholder: "Mot de passe",
                      secure: true,
                      onChangeText: _onPasswordChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      error ?? "",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontFamily: "regular",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 75),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Button(
                        text: "Se Connecter",
                        onPress: _onConnectPress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Button(
                        text: "S'inscrire",
                        onPress: _onSignUpPress,
                        secondary: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
