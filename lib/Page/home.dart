import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Class/vehicle_class.dart';
import 'package:mon_petit_entretien/Components/button_select.dart';
import 'package:mon_petit_entretien/Components/card_car.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Components/text_input.dart';
import 'package:mon_petit_entretien/Page/add_vehicule.dart';
import 'package:mon_petit_entretien/Page/web/home_web.dart';
import 'package:mon_petit_entretien/Services/api/vehicule.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';

import '../Style/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String search = "";
  Map<String, bool> select = <String, bool>{
    'KM': false,
    'DATE': false,
    'A-Z': false,
  };

  bool isLoaded = false;
  bool isSearching = false;
  final List<VehiculeModel> _searchVehicules =
      List<VehiculeModel>.empty(growable: true);

  void _onSearchChange(String newValue) {
    setState(() {
      search = newValue;
    });
    if (search.isNotEmpty) {
      AppData data;
      data = Provider.of<AppData>(context, listen: false);
      _searchVehicules.clear();
      for (VehiculeModel newVehicule in data.vehicles) {
        if (newVehicule.name.toLowerCase().contains(search) &&
            newVehicule.name[0].toLowerCase() == search[0]) {
          _searchVehicules.add(newVehicule);
        }
      }
      setState(() {
        isSearching = true;
      });
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }

  void _onSelectKM() async {
    if (select["KM"] == false) {
      if (isSearching == true) {
        final List<VehiculeModel> newVehiculesHigh =
            List<VehiculeModel>.empty(growable: true);
        newVehiculesHigh.addAll(_searchVehicules);

        newVehiculesHigh.sort((VehiculeModel a, VehiculeModel b) {
          return a.kilometrage.compareTo(b.kilometrage);
        });
        _searchVehicules.clear();
        for (VehiculeModel newVehicule in newVehiculesHigh) {
          _searchVehicules.add(newVehicule);
        }
      } else {
        AppData data;
        data = Provider.of<AppData>(context, listen: false);
        final List<VehiculeModel> newVehiculesHigh =
            List<VehiculeModel>.empty(growable: true);
        newVehiculesHigh.addAll(data.vehicles);

        newVehiculesHigh.sort((VehiculeModel a, VehiculeModel b) {
          return a.kilometrage.compareTo(b.kilometrage);
        });
        data.vehicles.clear();
        for (VehiculeModel newVehicule in newVehiculesHigh) {
          data.vehicles.add(newVehicule);
        }
      }
      setState(() {
        select["KM"] = true;
        select["A-Z"] = false;
        select["DATE"] = false;
      });
    } else {
      setState(() {
        select["KM"] = false;
      });
    }
  }

  void _onSelectDate() async {
    if (select["DATE"] == false) {
      if (isSearching == true) {
        final List<VehiculeModel> newVehiculesDate =
            List<VehiculeModel>.empty(growable: true);
        newVehiculesDate.addAll(_searchVehicules);

        newVehiculesDate.sort((VehiculeModel a, VehiculeModel b) {
          return a.date.compareTo(b.date);
        });
        _searchVehicules.clear();
        for (VehiculeModel newVehicule in newVehiculesDate) {
          _searchVehicules.add(newVehicule);
        }
      } else {
        AppData data;
        data = Provider.of<AppData>(context, listen: false);
        final List<VehiculeModel> newVehiculesDate =
            List<VehiculeModel>.empty(growable: true);
        newVehiculesDate.addAll(data.vehicles);

        newVehiculesDate.sort((VehiculeModel a, VehiculeModel b) {
          return a.date.compareTo(b.date);
        });

        data.vehicles.clear();
        for (VehiculeModel newVehicule in newVehiculesDate) {
          data.vehicles.add(newVehicule);
        }
      }
      setState(() {
        select["DATE"] = true;
        select["A-Z"] = false;
        select["KM"] = false;
      });
    } else {
      setState(() {
        select["DATE"] = false;
      });
    }
  }

  void _onSelectAlph() async {
    if (select["A-Z"] == false) {
      if (isSearching == true) {
        final List<VehiculeModel> newVehiculesAlph =
            List<VehiculeModel>.empty(growable: true);
        newVehiculesAlph.addAll(_searchVehicules);

        newVehiculesAlph.sort((VehiculeModel a, VehiculeModel b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        _searchVehicules.clear();
        for (VehiculeModel newVehicule in newVehiculesAlph) {
          _searchVehicules.add(newVehicule);
        }
      } else {
        AppData data;
        data = Provider.of<AppData>(context, listen: false);
        final List<VehiculeModel> newVehiculesAlph =
            List<VehiculeModel>.empty(growable: true);
        newVehiculesAlph.addAll(data.vehicles);

        newVehiculesAlph.sort((VehiculeModel a, VehiculeModel b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        data.vehicles.clear();
        for (VehiculeModel newVehicule in newVehiculesAlph) {
          data.vehicles.add(newVehicule);
        }
      }

      setState(() {
        select["A-Z"] = true;
        select["DATE"] = false;
        select["KM"] = false;
      });
    } else {
      setState(() {
        select["A-Z"] = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEveryVehicules();
  }

  void getEveryVehicules() async {
    AppData data;
    data = Provider.of<AppData>(context, listen: false);
    List<VehiculeModel> newVehicules;
    data.vehicles.clear();
    newVehicules = await getVehicles(data.token);
    for (VehiculeModel newVehicule in newVehicules) {
      data.vehicles.add(newVehicule);
    }
    if (data.vehicles.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double currentWith = MediaQuery.of(context).size.width;

    if (currentWith < 800) {
      return Material(
        color: lightBlue,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CommonText(
                      text: "Mes",
                      fontSizeText: 30,
                      fontWeight: fontLight,
                      paddingTop: 20,
                      paddingBot: 8,
                      color: navy,
                    ),
                    const CommonText(
                      text: "Véhicules",
                      fontSizeText: 30,
                      fontWeight: fontMedium,
                      paddingBot: 15,
                      color: navy,
                    ),
                    const CommonText(
                      text: "Gérez vos véhicules",
                      fontSizeText: 20,
                      fontWeight: fontLight,
                      paddingBot: 20,
                      color: navy,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextInput(
                        value: search,
                        placeholder: "Rechercher",
                        onChangeText: _onSearchChange,
                      ),
                    ),
                    const CommonText(
                      text: "Triez par :",
                      fontSizeText: 20,
                      fontWeight: fontLight,
                      paddingTop: 10,
                      paddingBot: 10,
                      color: navy,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonSelect(
                            text: "KM",
                            onPress: _onSelectKM,
                            isSelect: select["KM"],
                          ),
                          ButtonSelect(
                            text: "DATE",
                            onPress: _onSelectDate,
                            isSelect: select["DATE"],
                          ),
                          ButtonSelect(
                            text: "A-Z",
                            onPress: _onSelectAlph,
                            isSelect: select["A-Z"],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: 270,
                        width: 500,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<AddVehicule>(
                                      builder: (BuildContext context) =>
                                          const AddVehicule(),
                                    ),
                                  );
                                },
                                child: Ink(
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 270,
                                        width: 230,
                                        decoration: const BoxDecoration(
                                          color: navy,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                bottom: 10,
                                              ),
                                              child: Text(
                                                "Ajoutez\n un\n véhicule",
                                                style: TextStyle(
                                                  color: white,
                                                  fontSize: 30,
                                                  fontWeight: fontBold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 30,
                                                bottom: 25,
                                              ),
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: const BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: lightGray,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (isSearching == true)
                              for (VehiculeModel vehicule in _searchVehicules)
                                CardCar(
                                  name: vehicule.name,
                                  mileage: vehicule.kilometrage.toString(),
                                  nbMaintenance:
                                      vehicule.maintenances.length.toString(),
                                  pathImage: vehicule.picturePath,
                                  isLoaded: isLoaded,
                                ),
                            if (isSearching == false)
                              for (VehiculeModel vehicule
                                  in Provider.of<AppData>(
                                context,
                                listen: false,
                              ).vehicles)
                                CardCar(
                                  name: vehicule.name,
                                  mileage: vehicule.kilometrage.toString(),
                                  nbMaintenance:
                                      vehicule.maintenances.length.toString(),
                                  pathImage: vehicule.picturePath,
                                  isLoaded: isLoaded,
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const HomeWebPage();
    }
  }
}
