import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/class/maintenance_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/config/constants.dart';
import 'package:mon_petit_entretien/style/colors.dart';
import 'package:mon_petit_entretien/style/fonts.dart';
import 'package:provider/provider.dart';

import '../components/common_text.dart';

class VehicleView extends StatefulWidget {
  const VehicleView({Key? key}) : super(key: key);

  @override
  State<VehicleView> createState() => _VehicleView();
}

class _VehicleView extends State<VehicleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightBlue,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: kIsWeb ? 350 : 250,
                  width: kIsWeb ? 750 : MediaQuery.of(context).size.width * 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Image.network(
                      "$apiUrl/${Provider.of<AppData>(context, listen: false).thisVehicles.picturePath}",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              if (!kIsWeb)
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40, left: 12.5, right: 12.5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    iconSize: 35,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: kIsWeb ? 300 : 175),
                  child: Container(
                    height: kIsWeb ? 115 : 110,
                    width: kIsWeb ? 500 : 325,
                    decoration: BoxDecoration(
                      color: white,
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
                        CommonText(
                          text: Provider.of<AppData>(context, listen: false)
                              .thisVehicles
                              .name,
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
                                children: <Widget>[
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 25,
                                  ),
                                  CommonText(
                                    text: Provider.of<AppData>(
                                      context,
                                      listen: false,
                                    ).thisVehicles.date.substring(0, 10),
                                    fontSizeText: 17.5,
                                    fontWeight: fontLight,
                                    color: navy,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.mode_of_travel,
                                    size: 25,
                                  ),
                                  CommonText(
                                    text:
                                        '${Provider.of<AppData>(context, listen: false).thisVehicles.kilometrage} km',
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
                if (!kIsWeb)
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
              children: Provider.of<AppData>(context, listen: false)
                  .thisVehicles
                  .maintenances
                  .map(
                    (MaintenanceModel info) => CardVehicule(
                      prix: info.price.toString(),
                      title: info.name,
                      date: info.date.substring(0, 10),
                      km: info.kilometrage.toString(),
                      enterprise: info.center,
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SizedBox(
              width: kIsWeb ? 500 : 300,
              child: Button(
                text: "Ajouter un entretien",
                onPress: () => Navigator.pushNamed(context, '/addMaintenance'),
                keyTest: "add_maintenance_button",
              ),
            ),
          ),
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                width: 500,
                child: Button(
                  text: "Retour",
                  onPress: () => Navigator.pop(context),
                  keyTest: "vue_vehicule_back_button",
                ),
              ),
            ),
        ],
      ),
    );
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
        height: kIsWeb ? 150 : 140,
        width: kIsWeb ? 250 : 200,
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Container(
                height: kIsWeb ? 150 : 140,
                width: kIsWeb ? 50 : 40,
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
