import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:whatsapp_clone_flutter/core/models/conversations.dart';
import 'package:whatsapp_clone_flutter/core/models/profile.dart';
import 'package:whatsapp_clone_flutter/core/services/locator.dart';
import 'package:whatsapp_clone_flutter/core/view_models/contacts_model.dart';
import 'package:whatsapp_clone_flutter/core/view_models/userpage_model.dart';
import 'package:whatsapp_clone_flutter/features/conversationPage/conversationpage.dart';
import 'package:whatsapp_clone_flutter/features/groupPage/grouppage.dart';

import 'userpage_view_model.dart';

var userPageModel = GetIt.instance<UserPageModel>();

class UsersPageView extends UsersPageViewModel {
  @override
  void dispose() {
    userPageModel.selectedUsers = [];
    super.dispose();
  }

  Widget build(BuildContext context) {
    userPageModel.addListener(() {
      setState(() {});
    });

    return ChangeNotifierProvider(
      create: (BuildContext context) => userPageModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kişi Seç'),
          actions: userPageModel.selectedUsers.length != 0
              ? [
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GroupPage(
                              members: userPageModel.selectedUsers,
                              membersNames: userPageModel.selectedUsersNames)));
                    },
                  ),
                ]
              : [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: ContactSearchDelegate());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
        ),
        body: ContactList(
          query: '',
        ),
      ),
    );
  }
}

class ContactList extends StatefulWidget {
  final String query;
  ContactList({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    return ChangeNotifierProvider(
      create: (BuildContext context) => userPageModel,
      child: FutureBuilder(
        future: model.getContacts(widget.query),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            return ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.group),
                  ),
                  title: Text('Yeni Grup'),
                ),
                ...snapshot.data!
                    .map(
                      (profile) => Container(
                        color: (userPageModel.selectedUsers
                                .contains(profile.userId))
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.transparent,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(profile.pp),
                          ),
                          title: Text(profile.name + ' ' + profile.surname),
                          onTap: () async {
                            if (userPageModel.selectedUsers.length == 0) {
                              // liste dolu değilse
                              Conversation _conversation =
                                  await model.startConversation(
                                      FirebaseAuth.instance.currentUser!,
                                      profile);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ConversationPage(
                                      conversation: _conversation)));
                            } else {
                              // eğer grup için adam seçmiyorsa
                              userPageModel.onTapFunction(profile.userId,
                                  (profile.name + " " + profile.surname));
                            }
                            setState(() {});
                          },
                          onLongPress: () {
                            userPageModel.longPressFunction(profile.userId,
                                (profile.name + " " + profile.surname));
                            setState(() {});
                          },
                        ),
                      ),
                    )
                    .toList()
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
