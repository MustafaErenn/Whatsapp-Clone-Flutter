import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone_flutter/core/services/firestore_db.dart';
import 'package:whatsapp_clone_flutter/core/services/storage_service.dart';
import 'package:whatsapp_clone_flutter/core/view_models/chats_model.dart';
import 'package:whatsapp_clone_flutter/core/view_models/contacts_model.dart';
import 'package:whatsapp_clone_flutter/core/view_models/conversation_model.dart';
import 'package:whatsapp_clone_flutter/core/view_models/groupchats_model.dart';
import 'package:whatsapp_clone_flutter/core/view_models/grouppage_model.dart';
import 'package:whatsapp_clone_flutter/core/view_models/userpage_model.dart';

import 'auth.dart';

GetIt getIt = GetIt.instance;
setupLocators() {
  getIt.registerLazySingleton(() => FirestoreDB());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => StorageService());

  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => ContactsModel());
  getIt.registerFactory(() => ConversationModel());
  getIt.registerFactory(() => UserPageModel());
  getIt.registerFactory(() => GroupPageModel());
  getIt.registerFactory(() => GroupChatsModel());
}
