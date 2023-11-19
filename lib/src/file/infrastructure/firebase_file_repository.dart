import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/file/domain/i_file_repository.dart';

class FirebaseFileRepository implements IFileRepository {
  const FirebaseFileRepository(this._client);

  final FirebaseStorage _client;

  @override
  Future<DefaultResponse> deleteFile(String url) async {
    await _client.refFromURL(url).delete();
    return const DefaultResponse();
  }

  @override
  Future<DefaultResponse> uploadFile(File file) async {
    final TaskSnapshot task = await _client
        .ref()
        .child('images/${_generateId()}${path.extension(file.path)}')
        .putFile(file);
    return DefaultResponse(data: task.ref.getDownloadURL());
  }

  String _generateId([int length = 20]) {
    const String characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final Random rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(rnd.nextInt(characters.length)),
      ),
    );
  }
}
