import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_flutter/core/models/conversations.dart';
import 'package:whatsapp_clone_flutter/core/services/locator.dart';
import 'package:whatsapp_clone_flutter/core/view_models/grouppage_model.dart';
import 'package:whatsapp_clone_flutter/features/conversationPage/conversationpage.dart';
import 'package:whatsapp_clone_flutter/features/groupPage/grouppage.dart';

class GroupPageView extends State<GroupPage> {
  TextEditingController nameController = TextEditingController();
  String ppUrl = '';
  Widget build(BuildContext context) {
    var model = getIt<GroupPageModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Bu sayfa grubun detaylarını olusturacagımız sayfa'),
        actions: ((nameController.text == '') && (ppUrl == ''))
            ? []
            : [
                IconButton(
                    onPressed: () async {
                      Conversation _conversation =
                          await model.startGroupConversation(
                              widget.members, nameController.text, ppUrl);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ConversationPage(conversation: _conversation)));
                    },
                    icon: Icon(
                      Icons.thumb_up,
                    ))
              ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
            //
            children: [
              InkWell(
                onTap: () async {
                  ppUrl = await model.uploadGroupPP(ImageSource.camera);
                  setState(() {});
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(ppUrl == ''
                      ? 'https://firebasestorage.googleapis.com/v0/b/whatsapp-clone-flutter-54213.appspot.com/o/profileImages%2Fdefault_avatar.jpg?alt=media&token=da4bdd6b-2343-4395-a960-71f3d6184606'
                      : ppUrl),
                  radius: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                ),
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Grup Adı',
                  labelStyle: TextStyle(fontSize: 25),
                  border: OutlineInputBorder(),
                  hintText: 'örn: Üniversite Dayanışma Grubu',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Grup simgesi ve grup adını doldurunuz.'),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.members.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(widget.membersNames[index]),
                      ),
                    );
                  })
            ]),
      ),
    );
  }
}
