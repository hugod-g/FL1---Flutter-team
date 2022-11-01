import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import '../Components/commentText.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class VueVehiculePage extends StatefulWidget {

  const VueVehiculePage({Key? key}) : super(key: key);

  @override
  _VueVehiculePage createState() => _VueVehiculePage();
}

class _VueVehiculePage extends State<VueVehiculePage> {

  Widget vuevehicule() {
    return(
      Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: errorColor,
                  image: DecorationImage(
                    image: AssetImage('assets/image/logo.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 12.5, right: 12.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.integration_instructions),
                      iconSize: 35,
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.integration_instructions),
                      iconSize: 35,
                      onPressed: () {
                        print('lol');
                      },
                    ),
                  ],
                )
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 175),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.175,
                    width: MediaQuery.of(context).size.width * 0.875,
                    decoration: BoxDecoration(
                      color: white,
                      image: DecorationImage(
                        image: AssetImage('assets/image/logo.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(12.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const CommonText(
                          text: "Vehicule",
                          fontSizeText: 25,
                          fontWeight: fontBold,
                          paddingTop: 16,
                          paddingBot: 0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                     Icons.calendar_today,
                                      size: 25,
                                  ),
                                  const CommonText(
                                    text: "12/12/2022",
                                    fontSizeText: 17.5,
                                    fontWeight: fontLight,
                                    paddingTop: 0,
                                    paddingBot: 0,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                     Icons.mode_of_travel,
                                      size: 25,
                                  ),
                                  const CommonText(
                                    text: "2000 km",
                                    fontSizeText: 17.5,
                                    fontWeight: fontLight,
                                    paddingTop: 0,
                                    paddingBot: 0,
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonText(
                  text: "Mes entretiens",
                  fontSizeText: 25,
                  fontWeight: fontBold,
                  paddingTop: 0,
                  paddingBot: 0,
                ),
                Icon(
                    Icons.car_repair,
                    size: 35,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  @override
  //Main of the Login page (Body)
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body :
        vuevehicule(),
    );
  }
}