import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_flutter/core/models/conversations.dart';
import 'package:whatsapp_clone_flutter/core/view_models/groupchats_model.dart';
import 'package:whatsapp_clone_flutter/features/conversationPage/conversationpage.dart';
import 'package:whatsapp_clone_flutter/features/groupChatsPage/groupchatspage.dart';

class GroupsChatsPageView extends State<GroupsChatsPage> {
  Widget build(BuildContext context) {
    var model = GetIt.instance<GroupChatsModel>();
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: StreamBuilder<List<Conversation>>(
        stream: model.groups(FirebaseAuth.instance.currentUser!.uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!
                .map(
                  (document) => ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(document.profileImage)),
                    title: Text(document.name),
                    subtitle: Container(child: Text(document.displayMessage)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConversationPage(
                            conversation: Conversation(
                                id: document.id,
                                displayMessage: '',
                                name: document.name,
                                profileImage: document.profileImage),
                          ),
                        ),
                      );
                    },
                    trailing: Column(
                      children: <Widget>[
                        Text("19:30"),
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor),
                          child: Center(
                            child: Text(
                              "16",
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
