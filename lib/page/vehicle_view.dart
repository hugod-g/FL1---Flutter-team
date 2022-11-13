import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/class/maintenance_class.dart';
import 'package:mon_petit_entretien/class/vehicle_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/config/constants.dart';
import 'package:mon_petit_entretien/services/api/deleted_mantenance.dart';
import 'package:mon_petit_entretien/services/api/vehicle_spe.dart';
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
  bool isLoaded = true;

  void getVehicle() async {
    final AppData data = Provider.of<AppData>(context, listen: false);

    final VehiculeModel thisVehicle =
        await getSpeVehicle(data.token, data.thisVehicles.id);

    data.updateDataThisVehicle(
      thisVehicle.name,
      thisVehicle.kilometrage,
      thisVehicle.picturePath,
      thisVehicle.date,
      thisVehicle.id,
      thisVehicle.maintenances,
    );

    setState(() {
      isLoaded = true;
    });
  }

  SnackBar _status(bool status) {
    String message = "";

    if (status) {
      message = "Vous avez supprimé un entretien";
    } else {
      message = "Nous n'avons pas réussi à supprimer l'entretien";
    }

    final SnackBar snackBar = SnackBar(
      content: Text(
        message,
      ),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Ok',
        textColor: white,
        onPressed: () {},
      ),
    );

    return snackBar;
  }

  Future<int> _callApi(String id) async {
    final AppData data = Provider.of<AppData>(context, listen: false);
    final bool response = await deletedMaintenences(
      data.token,
      id,
    );

    if (response == true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_status(response));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_status(response));
      }
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightBlue,
      body: SingleChildScrollView(
        child: Column(
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
                        '$apiUrl/${Provider.of<AppData>(context, listen: false).thisVehicles.picturePath}',
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
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: navy,
                      ),
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
                                      text: isLoaded
                                          ? '${Provider.of<AppData>(context, listen: false).thisVehicles.kilometrage} km'
                                          : 'Chargement',
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
            const Padding(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
                top: 25,
              ),
              child: CommonText(
                text: "Mes entretiens",
                fontSizeText: 25,
                fontWeight: fontBold,
                color: navy,
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0125,
              ),
              scrollDirection: Axis.horizontal,
              child: isLoaded
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: Provider.of<AppData>(context, listen: false)
                          .thisVehicles
                          .maintenances
                          .map(
                            (MaintenanceModel info) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 7.5, right: 7.5),
                              child: Container(
                                height: kIsWeb ? 150 : 140,
                                width: kIsWeb ? 250 : 225,
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
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Icon(
                                                Icons.car_repair,
                                                size: 30,
                                              ),
                                              RotatedBox(
                                                quarterTurns: 3,
                                                child: CommonText(
                                                  text:
                                                      '${info.price.toString()} €',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          width: kIsWeb ? 175 : 155,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              CommonText(
                                                text: info.name.length >= 10
                                                    ? '${info.name.substring(0, 6)}...'
                                                    : info.name,
                                                fontSizeText: 19,
                                                fontWeight: fontBold,
                                                paddingLeft: 16,
                                                color: white,
                                              ),
                                              IconButton(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding: EdgeInsets.zero,
                                                onPressed: () =>
                                                    _callApi(info.id).then((_) {
                                                  setState(() {
                                                    isLoaded = false;
                                                  });
                                                  getVehicle();
                                                }),
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 27.5,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CommonText(
                                          text: info.date.substring(0, 10),
                                          fontSizeText: 17.5,
                                          fontWeight: fontLight,
                                          paddingTop: 10,
                                          paddingLeft: 16,
                                          color: white,
                                        ),
                                        CommonText(
                                          text:
                                              '${info.kilometrage.toString()} km',
                                          fontSizeText: 17.5,
                                          fontWeight: fontLight,
                                          paddingLeft: 16,
                                          color: white,
                                        ),
                                        CommonText(
                                          text: info.center.length >= 10
                                              ? '${info.center.substring(0, 6)}...'
                                              : info.center,
                                          fontSizeText: 15,
                                          fontWeight: fontLight,
                                          paddingTop: 10,
                                          paddingLeft: 16,
                                          paddingBot: 5,
                                          color: white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Container(),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Button(
                        text: "Ajouter un entretien",
                        onPress: () =>
                            Navigator.pushNamed(context, '/addMaintenance').then((_) {
                          setState(() {
                            isLoaded = false;
                          });
                          getVehicle();
                        }),
                        keyTest: "add_maintenance_button",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Button(
                        text: "Modifier les kilomètres de la voiture",
                        onPress: () =>
                            Navigator.pushNamed(context, '/update_km').then((_) {
                          setState(() {
                            isLoaded = false;
                          });
                          getVehicle();
                        }),
                        keyTest: "add_maintenance_button",
                      ),
                    ),
                    if (kIsWeb)
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Button(
                          text: "Retour",
                          onPress: () => Navigator.pop(context),
                          keyTest: "vue_vehicule_back_button",
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
