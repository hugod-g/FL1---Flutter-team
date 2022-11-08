import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
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
  // ignore: library_private_types_in_public_api
  _AddMaintenanceWebPage createState() => _AddMaintenanceWebPage();
}

class _AddMaintenanceWebPage extends State<AddMaintenanceWebPage> {
  
  late String mileage;
  String date = "";
  String price = "";
  late String name;
  String center = "";
  late AppData data;

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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: date,
                      placeholder: "Date",
                      onChangeText: _onDateChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: price,
                      placeholder: "Price",
                      onChangeText: _onPriceChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: name,
                      placeholder: "Name",
                      onChangeText: _onNameChange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextInput(
                      value: center,
                      placeholder: "Center",
                      onChangeText: _onCenterChange,
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
                                text: "Retour",
                                onPress: () => Navigator.pop(context),
                                secondary: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Button(
                                text: "Sauvegarder",
                                onPress: () => Navigator.pop(context),
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
