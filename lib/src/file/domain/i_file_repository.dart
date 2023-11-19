import 'dart:io';

import 'package:sales_control/src/common/domain/default_response.dart';

abstract class IFileRepository {
  const IFileRepository();

  Future<DefaultResponse> uploadFile(File file);

  Future<DefaultResponse> deleteFile(String url);
}
