import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/app_class.dart';
import 'package:mon_petit_entretien/class/maintenance_class.dart';
import 'package:mon_petit_entretien/components/button.dart';
import 'package:mon_petit_entretien/services/api/deleted_mantenance.dart';
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
                        maintenanceId: info.id,
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
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: SizedBox(
                width: kIsWeb ? 500 : 300,
                child: Button(
                  text: "Modifier les kilomètres de la voiture",
                  onPress: () => Navigator.pushNamed(context, '/update_km'),
                  keyTest: "add_maintenance_button",
                ),
              ),
            ),
            if (kIsWeb)
              Padding(
                padding: const EdgeInsets.only(top: 30),
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
      ),
    );
  }
}

class CardVehicule extends StatefulWidget {
  const CardVehicule({
    Key? key,
    required this.prix,
    required this.title,
    required this.date,
    required this.km,
    required this.maintenanceId,
    required this.enterprise,
  }) : super(key: key);

  final String prix;
  final String title;
  final String date;
  final String km;
  final String maintenanceId;
  final String enterprise;

  @override
  State<CardVehicule> createState() => _CardVehicule();
}

class _CardVehicule extends State<CardVehicule> {

  late AppData data;

  @override
  void initState() {
    super.initState();
    data = Provider.of<AppData>(context, listen: false);
  }

  SnackBar _status(bool status) {

    String message = "";
    
    if(status) {
      message = "Vous avez suprimer un entretiens";
    } else {
      message = "Nous n'avons pas réussie à suprimer la maintenance";
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

  void _callApi() async {
    final bool response = await deletedMaintenences(
      data.token,
      widget.maintenanceId,
    );

    if (response == true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_status(response));
        await Navigator.pushNamed(context, '/gestion');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(_status(response));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.5, right: 7.5),
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
                          text: '${widget.prix} €',
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
                Row(
                  children: <Widget> [
                    CommonText(
                      text: widget.title.length >= 10 ? '${widget.title.substring(0, 6)}...' : widget.title,
                      fontSizeText: 19,
                      fontWeight: fontBold,
                      paddingLeft: 16,
                      color: white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.5),
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.zero,
                        onPressed: _callApi,
                        icon: const Icon(
                          Icons.delete,
                          size: 27.5,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
                CommonText(
                  text: widget.date,
                  fontSizeText: 17.5,
                  fontWeight: fontLight,
                  paddingTop: 10,
                  paddingLeft: 16,
                  color: white,
                ),
                CommonText(
                  text: '${widget.km} km',
                  fontSizeText: 17.5,
                  fontWeight: fontLight,
                  paddingLeft: 16,
                  color: white,
                ),
                CommonText(
                  text: widget.enterprise.length >= 10 ? '${widget.enterprise.substring(0, 6)}...' : widget.enterprise,
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
