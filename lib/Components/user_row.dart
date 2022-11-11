import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/class/user_class.dart';
import 'package:mon_petit_entretien/components/common_text.dart';
import 'package:mon_petit_entretien/style/colors.dart';
import 'package:mon_petit_entretien/style/fonts.dart';

class UserRow extends StatefulWidget {
  const UserRow({
    super.key,
    required this.user,
    required this.onPress,
    required this.onDeletePress,
    required this.keyTestUpAdmin,
    required this.keyTestDelete,
  });

  final UserModel user;
  final void Function(String userId)? onPress;
  final void Function(String userId)? onDeletePress;
  final String keyTestUpAdmin;
  final String keyTestDelete;

  @override
  UserRowState createState() => UserRowState();
}

class UserRowState extends State<UserRow> {
  void _onButtonPress() {
    if (widget.onPress != null) {
      widget.onPress!(widget.user.id);
    }
  }

  void _onDeletePress() {
    if (widget.onDeletePress != null) {
      widget.onDeletePress!(widget.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: white,
          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 16, color: lightGray)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CommonText(
                  text: "${widget.user.firstName} ${widget.user.lastName}",
                  fontSizeText: 16,
                  fontWeight: fontRegular,
                  paddingLeft: 16,
                  color: navy,
                ),
                if (widget.user.admin)
                  const CommonText(
                    text: " (admin)",
                    fontSizeText: 16,
                    fontWeight: fontLight,
                    color: navy,
                  ),
              ],
            ),
            if (!widget.user.admin)
              Row(
                children: <Widget>[
                  IconButton(
                    key: Key(widget.keyTestUpAdmin),
                    onPressed: _onButtonPress,
                    icon: const Icon(Icons.upgrade),
                  ),
                  IconButton(
                    key: Key(widget.keyTestDelete),
                    onPressed: _onDeletePress,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
