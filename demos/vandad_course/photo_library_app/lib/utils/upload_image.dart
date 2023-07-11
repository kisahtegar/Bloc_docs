import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/// This function is used to handle uploading images taking `file` and `userId`
/// its grabbing that folder on data `userId`, creating a child (file) a wrap with a
/// random name after creating file and uploading then give a `bool` value.
Future<bool> uploadImage({
  required File file,
  required String userId,
}) =>
    FirebaseStorage.instance
        .ref(userId)
        .child(const Uuid().v4())
        .putFile(file)
        .then((_) => true)
        .catchError((_) => false);
