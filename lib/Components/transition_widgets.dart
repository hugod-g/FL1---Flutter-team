import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Page/add_vehicle.dart';

class TransitionList {
  static Route<dynamic> createRouteAddVehicule() {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          const AddVehicule(),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return rightTransition(context, animation, secondaryAnimation, child);
      },
    );
  }

  static Route<dynamic> createRouteViewVehicule() {
    //PUT VIEW VEHICLE
    return PageRouteBuilder<dynamic>(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          const AddVehicule(),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return leftTransition(context, animation, secondaryAnimation, child);
      },
    );
  }

  static Widget rightTransition(
    BuildContext context,
    Animation<dynamic> animation,
    Animation<dynamic> secondaryAnimation,
    Widget child,
  ) {
    const Offset begin = Offset(-1.0, 0.0);
    const Offset end = Offset.zero;
    const Curve curve = Curves.decelerate;

    final Animatable<Offset> tween =
        Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget leftTransition(
    BuildContext context,
    Animation<dynamic> animation,
    Animation<dynamic> secondaryAnimation,
    Widget child,
  ) {
    const Offset begin = Offset(1.0, 0.0);
    const Offset end = Offset.zero;
    const Curve curve = Curves.decelerate;

    final Animatable<Offset> tween =
        Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
