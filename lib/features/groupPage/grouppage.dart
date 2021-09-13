import 'package:flutter/cupertino.dart';

import 'grouppage_view.dart';

class GroupPage extends StatefulWidget {
  final List<String> members;
  final List<String> membersNames;
  const GroupPage({
    Key? key,
    required this.members,
    required this.membersNames,
  }) : super(key: key);
  GroupPageView createState() => GroupPageView();
}
