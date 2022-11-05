import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/button.dart';
import 'package:mon_petit_entretien/Page/web/vuevehicule_web.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

import '../Components/common_text.dart';

class VueVehiculePage extends StatefulWidget {
  const VueVehiculePage({Key? key}) : super(key: key);

  @override
  State<VueVehiculePage> createState() => _VueVehiculePage();
}

class _VueVehiculePage extends State<VueVehiculePage> {
  @override
  Widget build(BuildContext context) {
    final double currentWith = MediaQuery.of(context).size.width;
    const String prix = "200";
    const String title = "Roue";
    const String date = "12/20/2022";
    const String km = "2000";
    const String enterprise = "Point S";

    if (currentWith < 800) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightBlue,
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: errorColor,
                    image: DecorationImage(
                      image: AssetImage('assets/image/logo.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40, left: 12.5, right: 12.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.integration_instructions),
                        iconSize: 35,
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.integration_instructions),
                        iconSize: 35,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 175),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.175,
                      width: MediaQuery.of(context).size.width * 0.875,
                      decoration: const BoxDecoration(
                        color: white,
                        image: DecorationImage(
                          image: AssetImage('assets/image/logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          const CommonText(
                            text: "Vehicule",
                            fontSizeText: 25,
                            fontWeight: fontBold,
                            paddingTop: 16,
                            color: navy,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              right: 16,
                              left: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      size: 25,
                                    ),
                                    CommonText(
                                      text: "12/12/2022",
                                      fontSizeText: 17.5,
                                      fontWeight: fontLight,
                                      color: navy,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.mode_of_travel,
                                      size: 25,
                                    ),
                                    CommonText(
                                      text: "2000 km",
                                      fontSizeText: 17.5,
                                      fontWeight: fontLight,
                                      color: navy,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
                top: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  CommonText(
                    text: "Mes entretiens",
                    fontSizeText: 25,
                    fontWeight: fontBold,
                    color: navy,
                  ),
                  Icon(
                    Icons.car_repair,
                    size: 35,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0125,
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  CardVehicule(
                    prix: prix,
                    title: title,
                    date: date,
                    km: km,
                    enterprise: enterprise,
                  ),
                  CardVehicule(
                    prix: prix,
                    title: title,
                    date: date,
                    km: km,
                    enterprise: enterprise,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
              child: Button(
                text: "Ajouter un entretient",
                onPress: () => Navigator.pushNamed(context, '/add_maintenance'),
              ),
            ),
          ],
        ),
      );
    } else {
      return const VueVehiculeWebPage();
    }
  }
}

class CardVehicule extends StatelessWidget {
  const CardVehicule({
    Key? key,
    required this.prix,
    required this.title,
    required this.date,
    required this.km,
    required this.enterprise,
  }) : super(key: key);

  final String prix;
  final String title;
  final String date;
  final String km;
  final String enterprise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.21,
        width: MediaQuery.of(context).size.width * 0.55,
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.21,
                width: MediaQuery.of(context).size.width * 0.1,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Icon(
                        Icons.car_repair,
                        size: 30,
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: CommonText(
                          text: '$prix €',
                          fontSizeText: 17,
                          fontWeight: fontBold,
                          color: navy,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonText(
                  text: title,
                  fontSizeText: 20,
                  fontWeight: fontBold,
                  paddingTop: 8,
                  paddingLeft: 16,
                  color: white,
                ),
                CommonText(
                  text: date,
                  fontSizeText: 17.5,
                  fontWeight: fontLight,
                  paddingTop: 24,
                  paddingLeft: 16,
                  color: white,
                ),
                CommonText(
                  text: '$km km',
                  fontSizeText: 17.5,
                  fontWeight: fontLight,
                  paddingLeft: 16,
                  color: white,
                ),
                CommonText(
                  text: enterprise,
                  fontSizeText: 15,
                  fontWeight: fontLight,
                  paddingTop: 16,
                  paddingLeft: 16,
                  color: white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
