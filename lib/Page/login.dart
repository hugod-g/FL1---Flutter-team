import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/gestion.dart';
import 'package:mon_petit_entretien/Page/register.dart';
import 'package:mon_petit_entretien/Services/api/auth.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import '../Style/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
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
            builder: (BuildContext context) => const GestionPage(),
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
      color: lightBlue,
      child: SafeArea(
        child: Container(
          color: lightBlue,
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
                        color: navy,
                        fontSize: 30,
                        fontFamily: appFont,
                        fontWeight: fontLight,
                      ),
                    ),
                    Text(
                      "Garage",
                      style: TextStyle(
                        color: navy,
                        fontSize: 50,
                        fontFamily: appFont,
                        fontWeight: fontMedium,
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
                      color: navy,
                      fontSize: 16,
                      fontFamily: appFont,
                      fontWeight: fontLight,
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
                      color: navy,
                      fontSize: 16,
                      fontFamily: appFont,
                      fontWeight: fontLight,
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
                        isLoading: isLoading,
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
