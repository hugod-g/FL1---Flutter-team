import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mon_petit_entretien/Class/app_class.dart';
import 'package:mon_petit_entretien/Class/user_class.dart';
import 'package:mon_petit_entretien/Components/comment_text.dart';
import 'package:mon_petit_entretien/Components/user_row.dart';
import 'package:mon_petit_entretien/Components/web/burger_menu.dart';
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
    setState(() {
      isLoadingUsers = true;
    });

    final AppData data = Provider.of<AppData>(context, listen: false);

    final List<UserModel> userList = await getUserListCall(data.token);
    data.setUsersList(userList);
    setState(() {
      isLoadingUsers = false;
    });
  }

  void onUserPress(String userId) async {
    setState(() {
      isLoadingUsers = true;
    });
    final AppData data = Provider.of<AppData>(context, listen: false);

    final int responseStatus = await upgradeUserAdminCall(data.token, userId);

    if (responseStatus == 200) {
      getUserList();
    }
  }

  void onDeleteUserPress(String userId) async {
    final AppData data = Provider.of<AppData>(context, listen: false);

    final int responseStatus = await deleteUserAdminCall(data.token, userId);

    if (responseStatus == 200) {
      getUserList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              title: const Text('Mon Petit Entretient'),
              backgroundColor: blue,
            )
          : null,
      drawer: kIsWeb
          ? Theme(
              data: Theme.of(context).copyWith(canvasColor: gray),
              child: const BurgerMenu(),
            )
          : null,
      body: Material(
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
                      color: navy,
                    ),
                    const CommonText(
                      text: "Admin",
                      fontSizeText: 30,
                      fontWeight: fontMedium,
                      paddingBot: 15,
                      color: navy,
                    ),
                    const CommonText(
                      text: "Utilisateurs",
                      fontSizeText: 20,
                      fontWeight: fontLight,
                      paddingBot: 20,
                      color: navy,
                    ),
                    if (isLoadingUsers)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: const Align(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: navy,
                            ),
                          ),
                        ),
                      )
                    else
                      for (UserModel user
                          in Provider.of<AppData>(context, listen: false)
                              .usersList)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: UserRow(
                            user: user,
                            onPress: onUserPress,
                            onDeletePress: onDeleteUserPress,
                          ),
                        )
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
