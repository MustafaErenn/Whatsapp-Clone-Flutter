import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone_flutter/core/services/locator.dart';
import 'package:whatsapp_clone_flutter/core/view_models/conversation_model.dart';

import 'conversationpage_view_model.dart';

class ConversationPageView extends ConversationPageViewModel {
  var model = getIt<ConversationModel>();
  @override
  void initState() {
    super.initState();

    model.groupCheck(widget.conversation.id);
    model.getCurrentPersoName();
    model.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom != 0.0) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(microseconds: 200), curve: Curves.easeIn);
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.conversation.profileImage),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(widget.conversation.name),
              ),
            ],
          ),
        ),
        body: ChangeNotifierProvider(
          create: (BuildContext context) => model,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://placekitten.com/600/800"),
              ),
            ),
            child: model.nameAndSurname == ''
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => focusNode.unfocus(),
                          child: StreamBuilder(
                            stream: model.isGroup == true
                                ? model.getConversationGroups(
                                    widget.conversation.id)
                                : model.getConversation(widget.conversation.id),
                            builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) =>
                                !snapshot.hasData
                                    ? CircularProgressIndicator()
                                    : ListView(
                                        controller: scrollController,
                                        children: snapshot.data!.docs
                                            .map(
                                              (document) => ListTile(
                                                title: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: document['mediaUrl'] ==
                                                              null ||
                                                          document['mediaUrl']
                                                              .toString()
                                                              .isEmpty
                                                      ? Container()
                                                      : Align(
                                                          alignment: FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid ==
                                                                  document[
                                                                      'senderId']
                                                              ? Alignment
                                                                  .centerRight
                                                              : Alignment
                                                                  .bottomLeft,
                                                          child: SizedBox(
                                                            height: 200,
                                                            child:
                                                                Image.network(
                                                              document[
                                                                  'mediaUrl'],
                                                              loadingBuilder:
                                                                  (context,
                                                                      child,
                                                                      loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;

                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                                // You can use LinearProgressIndicator or CircularProgressIndicator instead
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                subtitle: Align(
                                                  alignment: FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid ==
                                                          document['senderId']
                                                      ? Alignment.centerRight
                                                      : Alignment.bottomLeft,
                                                  child: document['message']
                                                          .toString()
                                                          .isEmpty
                                                      ? Container()
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              borderRadius: BorderRadius.horizontal(
                                                                  left: Radius
                                                                      .circular(
                                                                          10),
                                                                  right: Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Container(
                                                            constraints:
                                                                BoxConstraints(
                                                                    minWidth:
                                                                        100,
                                                                    maxWidth:
                                                                        200),
                                                            child: ListView(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  ClampingScrollPhysics(),
                                                              children:
                                                                  model.isGroup ==
                                                                          false
                                                                      ? [
                                                                          Text(
                                                                            document['message'],
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                        ]
                                                                      : [
                                                                          Text(
                                                                            document['senderName'],
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 17,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          Text(
                                                                            document['message'],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ],
                                                            ),
                                                          )),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.circular(25))),
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.tag_faces,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      focusNode: focusNode,
                                      controller: editingController,
                                      decoration: InputDecoration(
                                          hintText: "Type a message",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await model
                                          .uploadMedia(ImageSource.gallery);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.attach_file,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await model
                                          .uploadMedia(ImageSource.camera);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(Icons.camera_alt,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: InkWell(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                //model.groupCheck(widget.conversation.id);
                                if (model.isGroup) {
                                  await model.addToGroups({
                                    'senderId': FirebaseAuth
                                        .instance.currentUser!.uid
                                        .toString(),
                                    'message': editingController.text,
                                    'senderName': model.nameAndSurname,
                                    'timeStamp': DateTime.now(),
                                    'mediaUrl': model.mediaUrl,
                                  }, widget.conversation.id);
                                  editingController.text = '';

                                  scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration: Duration(microseconds: 200),
                                      curve: Curves.easeIn);
                                } else {
                                  await model.add({
                                    'senderId': FirebaseAuth
                                        .instance.currentUser!.uid
                                        .toString(),
                                    'message': editingController.text,
                                    'timeStamp': DateTime.now(),
                                    'mediaUrl': model.mediaUrl,
                                  }, widget.conversation.id);
                                  editingController.text = '';

                                  scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration: Duration(microseconds: 200),
                                      curve: Curves.easeIn);
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
