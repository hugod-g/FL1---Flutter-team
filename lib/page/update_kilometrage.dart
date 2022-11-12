import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/components/text_input.dart';
import 'package:mon_petit_entretien/services/api/update_km.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';

import '../components/common_text.dart';
import '../style/colors.dart';

class UpdateKilometrage extends StatefulWidget {
  const UpdateKilometrage({Key? key}) : super(key: key);

  @override
  State<UpdateKilometrage> createState() => _UpdateKilometrage();
}

class _UpdateKilometrage extends State<UpdateKilometrage> {
  late String mileage;
  late AppData data;
  TextEditingController dateinput = TextEditingController();

  final SnackBar snackBar = SnackBar(
    content: const Text(
      "Tous les champs ne sont pas remplis !",
    ),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Ok',
      textColor: white,
      onPressed: () {},
    ),
  );

  @override
  void initState() {
    super.initState();
    data = Provider.of<AppData>(context, listen: false);
    mileage = data.thisVehicles.kilometrage.toString();
  }

  void _onMileageChange(String newValue) {
    setState(() {
      mileage = newValue;
    });
  }

  void _callApi() async {
    final bool response = await updateKilometrage(
      data.token,
      mileage,
      data.thisVehicles.id,
    );

    if (response == true) {
      if (mounted) {
        await Navigator.popAndPushNamed(context, '/gestion');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      if (kIsWeb)
                        const CommonText(
                          text: 'Modifier vos kilomètres',
                          fontSizeText: 30,
                          fontWeight: fontMedium,
                          paddingBot: 15,
                          color: navy,
                        )
                      else
                        Column(
                          children: const <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonText(
                                text: 'Modifier',
                                fontSizeText: 30,
                                fontWeight: fontLight,
                                paddingTop: 24,
                                paddingBot: 8,
                                color: navy,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonText(
                                text: 'vos kilomètres',
                                fontSizeText: 30,
                                fontWeight: fontMedium,
                                paddingBot: 15,
                                color: navy,
                              ),
                            ),
                          ],
                        ),
                      const Align(
                        alignment:
                            kIsWeb ? Alignment.center : Alignment.topLeft,
                        child: CommonText(
                          text: 'Modifier les kilomètres de votre voiture',
                          fontSizeText: kIsWeb ? 20 : 19.5,
                          fontWeight: fontLight,
                          paddingBot: 20,
                          color: navy,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: TextInput(
                            value: mileage,
                            placeholder: "Kilométrage (en km)",
                            onChangeText: _onMileageChange,
                            keyTest: "maintenance_input_mile",
                            textinput: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: Button(
                            text: "Sauvegarder",
                            onPress: _callApi,
                            keyTest: "add_maintenance_save_button",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 25),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: Button(
                            text: "Retour",
                            onPress: () => Navigator.pop(context),
                            secondary: true,
                            keyTest: "add_maintenance_back_button",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
