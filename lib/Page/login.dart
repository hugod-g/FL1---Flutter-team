import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/gestion.dart';
import 'package:mon_petit_entretien/Page/register.dart';
import 'package:mon_petit_entretien/Services/api/auth.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Style/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String email = "";
  String password = "";
  String? error;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      final String token = prefs.getString('token') ?? '';
      if (token.isNotEmpty) {
        final AppData data = Provider.of<AppData>(context, listen: false);
        data.setToken(token);
        // Navigator.popAndPushNamed(context, '/gestion');
      }
    });
  }

  void _onConnectPress() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final int responseStatus = await loginCall(email, password, context);

      if (responseStatus == 200) {
        // ignore: use_build_context_synchronously
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
    Navigator.popAndPushNamed(context, '/register');
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
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
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
                        color: errorColor,
                        fontSize: 16,
                        fontFamily: appFont,
                        fontWeight: fontLight,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
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
