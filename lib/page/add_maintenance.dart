import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/components/text_input.dart';
import 'package:mon_petit_entretien/services/api/add_maintenance.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';

import '../components/common_text.dart';
import '../style/colors.dart';

class AddMaintenancePage extends StatefulWidget {
  const AddMaintenancePage({Key? key}) : super(key: key);

  @override
  State<AddMaintenancePage> createState() => _AddMaintenancePage();
}

class _AddMaintenancePage extends State<AddMaintenancePage> {
  late String mileage;
  String date = "";
  String price = "";
  late String name;
  String center = "";
  late AppData data;
  TextEditingController dateinput = TextEditingController();

  final SnackBar snackBar = SnackBar(
    content: const Text(
      "Tout les champs ne sont pas remplis !",
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
    name = data.thisVehicles.name;
    mileage = data.thisVehicles.kilometrage.toString();
  }

  void _onMileageChange(String newValue) {
    setState(() {
      mileage = newValue;
    });
  }

  void _onDateChange(String newValue) {
    setState(() {
      date = newValue;
    });
  }

  void _onPriceChange(String newValue) {
    setState(() {
      price = newValue;
    });
  }

  void _onNameChange(String newValue) {
    setState(() {
      name = newValue;
    });
  }

  void _onCenterChange(String newValue) {
    setState(() {
      center = newValue;
    });
  }

  void _callApi() async {
    final bool response = await addMaintenance(
      data.token,
      mileage,
      date,
      price,
      name,
      center,
      data.thisVehicles.id,
    );

    if (response == true) {
      if (mounted) {
        Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      if (kIsWeb)
                        const CommonText(
                          text: 'Ajout d\'un entretient',
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
                                text: 'Ajout',
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
                                text: 'd\'un entretien',
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
                          text: 'Ajouter votre dernier entretien',
                          fontSizeText: 20,
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
                        child: Container(
                          height: 54,
                          width: kIsWeb ? 500 : 300,
                          decoration: const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(blurRadius: 16, color: lightGray)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 2,
                              ),
                              child: Center(
                                child: TextField(
                                  controller: dateinput,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    iconColor: navy,
                                    icon: Icon(Icons.calendar_today),
                                    labelText: "Date de l'entretien",
                                    labelStyle: TextStyle(color: navy),
                                    hintStyle: TextStyle(
                                      color: lightGray,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: appFont,
                                    fontWeight: fontRegular,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(
                                        2000,
                                      ),
                                      lastDate: DateTime(2101),
                                    );

                                    if (pickedDate != null) {
                                      final String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);

                                      setState(() {
                                        dateinput.text = formattedDate;
                                        _onDateChange(dateinput.text);
                                      });
                                    } else {}
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: TextInput(
                            value: price,
                            placeholder: "Prix",
                            onChangeText: _onPriceChange,
                            keyTest: "add_maintenance_input_price",
                            textinput: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: TextInput(
                            value: name,
                            placeholder: "Nom de l'entretien (ex: Courroie)",
                            onChangeText: _onNameChange,
                            keyTest: "add_maintenance_input_name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: TextInput(
                            value: center,
                            placeholder: "Centre",
                            onChangeText: _onCenterChange,
                            keyTest: "add_maintenance_input_center",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          width: kIsWeb ? 500 : 300,
                          child: Button(
                            text: "Ajouter l'entretien",
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
          ],
        ),
      ),
    );
  }
}
