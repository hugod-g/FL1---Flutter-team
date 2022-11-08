import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/web/addmaintenance_web.dart';
import 'package:mon_petit_entretien/Services/api/add_maintenance.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';

import '../Components/common_text.dart';
import '../Style/colors.dart';

class AddMaintenancePage extends StatefulWidget {
  const AddMaintenancePage({
    super.key,
    required this.name,
    required this.mileage,
    required this.vehicleId,
  });

  final String name;
  final String mileage;
  final String vehicleId;

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
    final double currentWith = MediaQuery.of(context).size.width;

    if (currentWith < 800) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightBlue,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.0125,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.topLeft,
                        child: CommonText(
                          text: 'Ajout',
                          fontSizeText: 30,
                          fontWeight: fontLight,
                          paddingTop: 44,
                          paddingBot: 8,
                          color: navy,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: CommonText(
                          text: 'd\'un entretient',
                          fontSizeText: 30,
                          fontWeight: fontMedium,
                          paddingBot: 15,
                          color: navy,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: CommonText(
                          text: 'Ajouter votre dernier entretient',
                          fontSizeText: 20,
                          fontWeight: fontLight,
                          paddingBot: 20,
                          color: navy,
                        ),
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
                        padding: const EdgeInsets.only(top: 40),
                        child: Button(
                          text: "Sauvegarder",
                          onPress: () =>
                            addMaintenance(data.token, mileage, date, price, name, center, widget.vehicleId),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 25),
                        child: Button(
                          text: "Retour",
                          onPress: () => Navigator.pop(context),
                          secondary: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return AddMaintenanceWebPage(
        name: widget.name,
        mileage: widget.mileage,
        vehicleId: widget.vehicleId,
      );
    }
  }
}
