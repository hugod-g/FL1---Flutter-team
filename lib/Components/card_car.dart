import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Style/colors.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';

class CardCar extends StatefulWidget {
  const CardCar({
    super.key,
    required this.name,
    required this.mileage,
    required this.nbMaintenance,
    required this.pathImage,
    required this.isLoaded,
  });

  final String name;
  final String mileage;
  final String nbMaintenance;
  final String pathImage;
  final bool isLoaded;

  @override
  CardCarState createState() => CardCarState();
}

class CardCarState extends State<CardCar> {
  @override
  Widget build(BuildContext context) {
    print("le véhicule est ${widget.name}");
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        child: Ink(
          child: Stack(
            children: <Widget>[
              if (widget.isLoaded)
                SizedBox(
                  height: 270,
                  width: 230,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "http://152.228.134.93:1339/${widget.pathImage}",
                      loadingBuilder: (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) {
                          return FittedBox(
                            fit: BoxFit.cover,
                            child: child,
                          );
                        }
                        return Container(
                          color: navy,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: white,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              else
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: navy,
                  ),
                ),
              SizedBox(
                height: 270,
                width: 230,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(
                              color: white,
                              fontSize: 30,
                              fontWeight: fontBold,
                            ),
                          ),
                          Text(
                            "${widget.mileage} km",
                            style: const TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: fontMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                            child: Align(
                              child: Text(
                                widget.nbMaintenance,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: fontBold,
                                ),
                              ),
                            ),
                          ),
                        ],
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
