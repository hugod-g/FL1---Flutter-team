import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Class/user_class.dart';
import 'package:mon_petit_entretien/Components/comment_text.dart';
import 'package:mon_petit_entretien/Components/user_row.dart';
import 'package:mon_petit_entretien/Services/api/admin.dart';
import 'package:mon_petit_entretien/Style/fonts.dart';
import 'package:provider/provider.dart';
import '../Style/colors.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  bool isLoadingUsers = false;
  @override
  void initState() {
    super.initState();
    getUserList();
  }

  void getUserList() async {
    final AppData data = Provider.of<AppData>(context, listen: false);

    final List<UserModel> userList = await getUserListCall(data.token);
    data.setUsersList(userList);
  }

  void onUserPress(String userId) {}

  void onDeleteUserPress(String userId) {}

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightBlue,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CommonText(
                    text: "Ma partie",
                    fontSizeText: 30,
                    fontWeight: fontLight,
                    paddingTop: 20,
                    paddingBot: 8,
                  ),
                  const CommonText(
                    text: "Admin",
                    fontSizeText: 30,
                    fontWeight: fontMedium,
                    paddingBot: 15,
                  ),
                  const CommonText(
                    text: "Utilisateurs",
                    fontSizeText: 20,
                    fontWeight: fontLight,
                    paddingBot: 20,
                  ),
                  for (UserModel user
                      in Provider.of<AppData>(context, listen: false).usersList)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: UserRow(
                          user: user,
                          onPress: onUserPress,
                          onDeletePress: onDeleteUserPress),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
