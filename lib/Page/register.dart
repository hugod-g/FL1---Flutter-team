import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/gestion.dart';
import 'package:mon_petit_entretien/Services/api/auth.dart';
import '../Style/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String email = "";
  String password = "";
  String firstname = "";
  String lastname = "";
  bool isLoading = false;
  String? error;

  void _onBackPress() {
    Navigator.pop(context);
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

  void _onFirstnameChange(String newValue) {
    setState(() {
      firstname = newValue;
    });
  }

  void _onLastnameChange(String newValue) {
    setState(() {
      lastname = newValue;
    });
  }

  void _registerPress() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final int response =
          await registerCall(email, password, firstname, lastname);

      if (response == 200) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          onPressed: _onBackPress,
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const Text(
                        "Inscription",
                        style: TextStyle(color: grisfoncer, fontSize: 24),
                      ),
                      const SizedBox(
                        width: 30,
                        child: Material(),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Text(
                      "Prénom",
                      style: TextStyle(
                        color: grisfoncer,
                        fontSize: 16,
                        fontFamily: "regular",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    child: TextInput(
                      value: firstname,
                      placeholder: "Prénom",
                      onChangeText: _onFirstnameChange,
                    ),
                  ),
                  const Text(
                    "Nom",
                    style: TextStyle(
                      color: grisfoncer,
                      fontSize: 16,
                      fontFamily: "regular",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    child: TextInput(
                      value: lastname,
                      placeholder: "Nom",
                      onChangeText: _onLastnameChange,
                    ),
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: grisfoncer,
                      fontSize: 16,
                      fontFamily: "regular",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
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
                      fontFamily: "regular",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextInput(
                      value: password,
                      placeholder: "Mot de passe",
                      onChangeText: _onPasswordChange,
                      secure: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      error ?? "",
                      textAlign: TextAlign.center,
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
                padding: const EdgeInsets.only(top: 32),
                child: Button(
                  text: "S'inscrire",
                  onPress: _registerPress,
                  isLoading: isLoading,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
