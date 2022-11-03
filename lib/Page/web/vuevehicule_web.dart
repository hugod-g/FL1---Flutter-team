import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Components/web/burgerMenu.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

import '../../Components/commentText.dart';

class VueVehiculeWebPage extends StatefulWidget {

  const VueVehiculeWebPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VueVehiculeWebPage createState() => _VueVehiculeWebPage();
}

class _VueVehiculeWebPage extends State<VueVehiculeWebPage> {

  final String prix = "200";
  final String title = "Roue";
  final String date = "12/20/2022";
  final String km = "2000";
  final String enterprise = "Point S";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body : Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 375, right: 375, bottom: 50),
            child: Column(
              children: <Widget> [
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
                      padding: const EdgeInsets.only(top: 40, left: 12.5, right: 12.5),
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
                            onPressed: () {
                            },
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 312.5),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            color: white,
                            image: const DecorationImage(
                              image: AssetImage('assets/image/logo.png'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12.5),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              const CommonText(
                                text: "Vehicules",
                                fontSizeText: 25,
                                fontWeight: fontBold,
                                paddingTop: 16,
                                color: navy,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
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
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150, right: 150, bottom: 25, top: 25),
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
            padding: const EdgeInsets.only(top: 50, left: 25, right: 75),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                CardVehiculeWeb(
                  prix: prix,
                  title: title,
                  date: date,
                  km: km,
                  enterprise: enterprise,
                ),
                CardVehiculeWeb(
                  prix: prix,
                  title: title,
                  date: date,
                  km: km,
                  enterprise: enterprise,
                  ),
              ],
            ),
          ),
        ],
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

class CardVehiculeWeb extends StatelessWidget {

  const CardVehiculeWeb(
    {Key? key,
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
    return 
      Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(12.5),
          ),
          child: Row(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.05,
                  color: white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
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
                children: <Widget> [
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
              )
            ],
          ),
        ),
      )
    ;
  }
}