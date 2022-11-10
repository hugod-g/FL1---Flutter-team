import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/class/vehicle_class.dart';
import 'package:mon_petit_entretien/components/button_select.dart';
import 'package:mon_petit_entretien/components/card_car.dart';
import 'package:mon_petit_entretien/components/common_text.dart';
import 'package:mon_petit_entretien/components/text_input.dart';
import 'package:mon_petit_entretien/components/web/burger_menu.dart';
import 'package:mon_petit_entretien/page/add_vehicle.dart';
import 'package:mon_petit_entretien/services/api/vehicule.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:mon_petit_entretien/Components/transition_widgets.dart';
import 'package:provider/provider.dart';

import '../style/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  String search = "";
  Map<String, bool> select = <String, bool>{
    'KM': false,
    'DATE': false,
    'A-Z': true,
  };

  late AnimationController rotationControllerDate;
  late AnimationController rotationControllerAlph;
  late AnimationController rotationControllerKM;

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
    rotationControllerKM.forward(from: 0.0);
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
  }

  void _onSelectDate() async {
    rotationControllerDate.forward(from: 0.0);
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
  }

  void _onSelectAlph() async {
    rotationControllerAlph.forward(from: 0.0);
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
  }

  @override
  void initState() {
    super.initState();
    rotationControllerKM = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    rotationControllerDate = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    rotationControllerAlph = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    getEveryVehicules();
  }

  void getEveryVehicules() async {
    AppData data;
    data = Provider.of<AppData>(context, listen: false);
    List<VehiculeModel> newVehiculesAlphSort;
    data.vehicles.clear();
    newVehiculesAlphSort = await getVehicles(data.token);
    newVehiculesAlphSort.sort((VehiculeModel a, VehiculeModel b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    data.vehicles.clear();
    for (VehiculeModel newVehicule in newVehiculesAlphSort) {
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
    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              title: const Text('Mon Petit Entretient'),
              backgroundColor: blue,
            )
          : null,
      drawer: kIsWeb
          ? Theme(
              data: Theme.of(context).copyWith(canvasColor: gray),
              child: const BurgerMenu(),
            )
          : null,
      resizeToAvoidBottomInset: !kIsWeb,
      body: Material(
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
                    if (kIsWeb)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: TextInput(
                            value: search,
                            placeholder: "Rechercher",
                            onChangeText: _onSearchChange,
                            keyTest: "home_input_search",
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: TextInput(
                          value: search,
                          placeholder: "Rechercher",
                          onChangeText: _onSearchChange,
                          keyTest: "home_input_search",
                        ),
                      ),
                    const CommonText(
                      text: "Trier par :",
                      fontSizeText: 20,
                      fontWeight: fontLight,
                      paddingTop: 10,
                      paddingBot: 10,
                      color: navy,
                    ),
                    if (kIsWeb)
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ButtonSelect(
                              text: "A-Z",
                              onPress: _onSelectAlph,
                              isSelect: select["A-Z"],
                              keyTest: "alph_sort_button",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: ButtonSelect(
                              text: "KM",
                              onPress: _onSelectKM,
                              isSelect: select["KM"],
                              keyTest: "km_sort_button",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: ButtonSelect(
                              text: "DATE",
                              onPress: _onSelectDate,
                              isSelect: select["DATE"],
                              keyTest: "date_sort_button",
                            ),
                          ),
                        ],
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RotationTransition(
                              turns: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(rotationControllerAlph),
                              child: ButtonSelect(
                                text: "A-Z",
                                onPress: _onSelectAlph,
                                isSelect: select["A-Z"],
                              ),
                            ),
                            RotationTransition(
                              turns: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(rotationControllerKM),
                              child: ButtonSelect(
                                text: "KM",
                                onPress: _onSelectKM,
                                isSelect: select["KM"],
                              ),
                            ),
                            RotationTransition(
                              turns: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(rotationControllerDate),
                              child: ButtonSelect(
                                text: "DATE",
                                onPress: _onSelectDate,
                                isSelect: select["DATE"],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: 270,
                        width: kIsWeb ? double.infinity : 500,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: InkWell(
                                key: const Key("go_to_add_vehicule_page"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    TransitionList.createRouteAddVehicule(),
                                  ).then((_) {
                                    setState(() {
                                      isLoaded = false;
                                    });
                                    getEveryVehicules();
                                  });
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
                            if (isSearching)
                              for (VehiculeModel vehicule in _searchVehicules)
                                CardCar(
                                  name: vehicule.name,
                                  mileage: vehicule.kilometrage.toString(),
                                  nbMaintenance:
                                      vehicule.maintenances.length.toString(),
                                  pathImage: vehicule.picturePath,
                                  isLoaded: isLoaded,
                                  date: vehicule.date,
                                  id: vehicule.id,
                                  maintenance: vehicule.maintenances,
                                )
                            else
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
                                  date: vehicule.date,
                                  id: vehicule.id,
                                  maintenance: vehicule.maintenances,
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
      ),
    );
  }
}
