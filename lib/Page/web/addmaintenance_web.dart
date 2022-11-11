import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
import 'package:mon_petit_entretien/Services/api/add_maintenance.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';

class AddMaintenanceWebPage extends StatefulWidget {
  const AddMaintenanceWebPage({
    super.key,
    required this.name,
    required this.mileage,
    required this.vehicleId,
  });

  final String name;
  final String mileage;
  final String vehicleId;

  @override
  State<AddMaintenanceWebPage> createState() => _AddMaintenanceWebPage();
}

class _AddMaintenanceWebPage extends State<AddMaintenanceWebPage> {
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
    name = widget.name;
    mileage = widget.mileage;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightBlue,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 75, bottom: 125, left: 600, right: 600),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  const CommonText(
                    text: 'Ajout d\'un entretient',
                    fontSizeText: 40,
                    fontWeight: fontMedium,
                    paddingTop: 44,
                    paddingBot: 8,
                    color: navy,
                  ),
                  const CommonText(
                    text: 'Ajouter votre dernier entretient',
                    fontSizeText: 30,
                    fontWeight: fontLight,
                    paddingBot: 20,
                    color: navy,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: mileage,
                      placeholder: "Mile",
                      onChangeText: _onMileageChange,
                      keyTest: "add_maintenance_input_mile_web",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      height: 54,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(blurRadius: 16, color: lightGray)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
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
                                labelText: "Date d'achat",
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
                    child: TextInput(
                      value: price,
                      placeholder: "Price",
                      onChangeText: _onPriceChange,
                      keyTest: "add_maintenance_input_price_web",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Name",
                      onChangeText: _onNameChange,
                      keyTest: "add_maintenance_input_name_web",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: center,
                      placeholder: "Center",
                      onChangeText: _onCenterChange,
                      keyTest: "add_maintenance_input_center_web",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 75),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Button(
                                text: "Sauvegarder",
                                onPress: () async => await addMaintenance(
                                          data.token,
                                          mileage,
                                          date,
                                          price,
                                          name,
                                          center,
                                          widget.vehicleId,
                                        ) ==
                                        true
                                    ? Navigator.popAndPushNamed(
                                        context,
                                        '/home',
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar),
                                keyTest: "add_maintenance_save_button_web",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Button(
                                text: "Retour",
                                onPress: () => Navigator.pop(context),
                                secondary: true,
                                keyTest: "add_maintenance_back_button_web",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Mon Petit Entretient'),
        backgroundColor: blue,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: gray),
        child: const BurgerMenu(),
      ),
    );
  }
}
