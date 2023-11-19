import 'dart:io';

import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/file/domain/i_file_repository.dart';

class FileService {
  const FileService(this._repository);

  final IFileRepository _repository;

  Future<String> uploadFile(File file) async {
    final DefaultResponse response = await _repository.uploadFile(file);
    return response.data as String;
  }

  Future<void> deleteFile(String url) async {
    await _repository.deleteFile(url);
  }
}
