import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/components/text_input.dart';
import 'package:mon_petit_entretien/services/api/auth.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';
import '../style/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
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
      AppData data;
      data = Provider.of<AppData>(context, listen: false);
      final int response =
          await registerCall(email, password, firstname, lastname, data);

      if (response == 200 && mounted) {
        await Navigator.popAndPushNamed(context, '/gestion');
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
    final double currentWith = MediaQuery.of(context).size.width;

    return Material(
      color: lightBlue,
      child: SafeArea(
        child: Container(
          color: lightBlue,
          child: ListView(
            children: <Widget>[
              Padding(
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
                              child: IconButton(
                                iconSize: currentWith < 800 ? 32 : 40,
                                onPressed: _onBackPress,
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                            Text(
                              "Inscription",
                              style: TextStyle(
                                color: navy,
                                fontSize: currentWith < 800 ? 24 : 42,
                                fontFamily: appFont,
                                fontWeight: fontMedium,
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                              child: Material(),
                            ),
                          ],
                        ),
                        Align(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 800),
                            child: Column(
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 24),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Prénom",
                                      style: TextStyle(
                                        color: navy,
                                        fontSize: 16,
                                        fontFamily: appFont,
                                        fontWeight: fontLight,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 24),
                                  child: TextInput(
                                    value: firstname,
                                    placeholder: "Prénom",
                                    onChangeText: _onFirstnameChange,
                                    keyTest: "sign_up_input_first_name",
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Nom",
                                    style: TextStyle(
                                      color: navy,
                                      fontSize: 16,
                                      fontFamily: appFont,
                                      fontWeight: fontLight,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 24),
                                  child: TextInput(
                                    value: lastname,
                                    placeholder: "Nom",
                                    onChangeText: _onLastnameChange,
                                    keyTest: "sign_up_input_last_name",
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: navy,
                                      fontSize: 16,
                                      fontFamily: appFont,
                                      fontWeight: fontLight,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 24),
                                  child: TextInput(
                                    value: email,
                                    placeholder: "Adresse E-mail",
                                    onChangeText: _onEmailChange,
                                    keyTest: "sign_up_input_email",
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Mot de passe",
                                    style: TextStyle(
                                      color: navy,
                                      fontSize: 16,
                                      fontFamily: appFont,
                                      fontWeight: fontLight,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 16),
                                  child: TextInput(
                                    value: password,
                                    placeholder: "Mot de passe",
                                    onChangeText: _onPasswordChange,
                                    secure: true,
                                    keyTest: "sign_up_input_pw",
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 16),
                                  child: Text(
                                    error ?? "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: errorColor,
                                      fontSize: 16,
                                      fontFamily: appFont,
                                      fontWeight: fontLight,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: Button(
                                    text: "S'inscrire",
                                    onPress: _registerPress,
                                    isLoading: isLoading,
                                    keyTest: "sign_up_button",
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
