import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  void _callApi() async {

    final bool response = await addMaintenance(data.token, mileage, date, price, name, center, widget.vehicleId);

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
    final double currentWith = MediaQuery.of(context).size.width;

    if (currentWith < 800) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightBlue,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 15),
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
                          onPress: _callApi,
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
