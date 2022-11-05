import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Class/maintenance_class.dart';
import 'package:mon_petit_entretien/Class/vehicle_class.dart';
import 'package:mon_petit_entretien/Components/common_text.dart';
import 'package:mon_petit_entretien/Page/web/stat_web.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';
import '../Style/colors.dart';

class Statistique extends StatefulWidget {
  const Statistique({Key? key}) : super(key: key);

  @override
  State<Statistique> createState() => _Statistique();
}

class _Statistique extends State<Statistique> {
  int statMaintenances = 0;

  @override
  void initState() {
    super.initState();
    getStatMaintenance();
  }

  void getStatMaintenance() async {
    AppData data;
    data = Provider.of<AppData>(context, listen: false);
    int tempPrice = 0;
    for (VehiculeModel vehicule in data.vehicles) {
      for (maintenanceModel maintenance in vehicule.maintenances) {
        tempPrice += int.parse(maintenance.prix);
      }
    }
    setState(() {
      statMaintenances = tempPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double currentWith = MediaQuery.of(context).size.width;

    if (currentWith < 800) {
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
                  color: navy,
                ),
                const CommonText(
                  text: "Stats",
                  fontSizeText: 30,
                  fontWeight: fontMedium,
                  paddingBot: 15,
                  color: navy,
                ),
                const CommonText(
                  text: "Surveillez vos coûts",
                  fontSizeText: 20,
                  fontWeight: fontLight,
                  paddingBot: 20,
                  color: navy,
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        CommonText(
                          text: "$statMaintenances €",
                          fontSizeText: 50,
                          fontWeight: fontBold,
                          color: navy,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CommonText(
                            text: "Total",
                            fontSizeText: 20,
                            fontWeight: fontLight,
                            color: navy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const StatWebPage();
    }
  }
}
