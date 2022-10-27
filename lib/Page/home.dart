import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Components/buttonSelect.dart';
import 'package:mon_petit_entretien/Components/commentText.dart';
import 'package:mon_petit_entretien/Page/addVehicule.dart';
import 'package:provider/provider.dart';
import '../Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

import 'package:mon_petit_entretien/Components/text_input.dart';

import '../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String search = "";
  Map<String, bool> select = {
    'KM': false,
    'DATE': false,
    'A-Z': false,
  };

  void _onSearchChange(String newValue) {
    setState(() {
      search = newValue;
    });
  }

  void _onSelectKM() async {
    if (select["KM"] == false) {
      setState(() {
        select["KM"] = true;
      });
    } else {
      setState(() {
        select["KM"] = false;
      });
    }
  }

  void _onSelectDate() async {
    if (select["DATE"] == false) {
      setState(() {
        select["DATE"] = true;
      });
    } else {
      setState(() {
        select["DATE"] = false;
      });
    }
  }

  void _onSelectAlph() async {
    if (select["A-Z"] == false) {
      setState(() {
        select["A-Z"] = true;
      });
    } else {
      setState(() {
        select["A-Z"] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightBlue,
      child: SafeArea(
        child: Padding(
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
              ),
              const CommonText(
                text: "Véhicules",
                fontSizeText: 30,
                fontWeight: fontMedium,
                paddingBot: 15,
              ),
              const CommonText(
                text: "Gérez vos véhicules",
                fontSizeText: 20,
                fontWeight: fontLight,
                paddingBot: 20,
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
                  paddingBot: 10),
              _sortCar(),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: _listCar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listCar() {
    return Container(
      height: 270,
      width: 500,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _addCar(),
          _showCar(),
          _showCar(),
          _showCar(),
        ],
      ),
    );
  }

  Widget _sortCar() {
    return Padding(
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
    );
  }

  Widget _addCar() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          Map data = {
            'name': 'marie',
            'email': 'example@example.com',
            'age': 42
          };

          Navigator.push(
            context,
            // ignore: always_specify_types
            MaterialPageRoute(
              builder: (BuildContext context) => const AddVehicule(),
            ),
          );
          print("ADD CAR");
        },
        child: Ink(
          child: Stack(
            children: [
              Container(
                height: 270,
                width: 230,
                decoration: const BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              Row(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
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
                      padding: const EdgeInsets.only(left: 30, bottom: 25),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
    );
  }

  Widget _showCar() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          print("SHOW CAR");
        },
        child: Ink(
          child: Stack(
            children: [
              Container(
                height: 270,
                width: 230,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/car.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                  /*DecorationImage(
                    fit: BoxFit.fill,
                    image:  //NetworkImage(
                      //"https://picsum.photos/250?image=9",
                    ), 
                  ),*/
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "Véhicule",
                            style: TextStyle(
                              color: white,
                              fontSize: 30,
                              fontWeight: fontBold,
                            ),
                          ),
                          Text(
                            "99 987" + " km",
                            style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: fontMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Text(
                                "entretiens",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: fontMedium,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "4",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: fontBold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
