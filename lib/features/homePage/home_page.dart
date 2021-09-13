import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/core/services/auth.dart';
import 'package:whatsapp_clone_flutter/features/chatPage/chatpage.dart';
import 'package:whatsapp_clone_flutter/features/groupChatsPage/groupchatspage.dart';
import 'package:whatsapp_clone_flutter/features/loginPage/loginpage.dart';
import 'package:whatsapp_clone_flutter/features/userPage/userpage.dart';

class WhatsappCloneHomePage extends StatefulWidget {
  WhatsappCloneHomePage({Key? key}) : super(key: key);

  @override
  _WhatsappCloneHomePageState createState() => _WhatsappCloneHomePageState();
}

class _WhatsappCloneHomePageState extends State<WhatsappCloneHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Whatsapp Clone'),
          actions: [PopUpOptionMenu()],
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Sohbetler',
              ),
              Tab(
                text: 'Gruplar',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [ChatPage(), GroupsChatsPage()]),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UsersPage()));
          },
        ),
      ),
    );
  }
}

enum MenuOption { Profile, SignOut }

class PopUpOptionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      itemBuilder: (context) {
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            child: ListTile(
              title: Text('Ayarlar'),
              onTap: () {},
              trailing: Icon(Icons.settings),
            ),
            value: MenuOption.Profile,
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('Çıkış'),
              onTap: () async {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                        title: 'Çıkış Yap',
                        bodyText: "Çıkış yapmak istediğinize emin misiniz",
                        button1Text: "Evet",
                        button2Text: "Hayır",
                      );
                    });
              },
              trailing: Icon(Icons.logout),
            ),
            value: MenuOption.SignOut,
          )
        ];
      },
    );
  }
}

// ignore: must_be_immutable
class MyAlertDialog extends StatefulWidget {
  String title;
  String bodyText;
  String button1Text;
  String button2Text;

  MyAlertDialog(
      {required this.title,
      required this.bodyText,
      required this.button1Text,
      required this.button2Text});

  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${this.widget.title}'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('${this.widget.bodyText}'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('${this.widget.button1Text}'),
          onPressed: () async {
            _authService.signOut().then((value) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            });
          },
        ),
        TextButton(
          child: Text('${this.widget.button2Text}'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
