import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PictureLoader {
  final Dio _dio = Dio();

  Future<bool> checkPicture(String url) async {
    try {
      final response = await _dio.get(url);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<String> loadPicture(String url) async {
    final pictureDir = await getApplicationDocumentsDirectory();
    String filename = url.split('/').last;
    try {
      Response response = await _dio.get(
        url,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      File file = File('${pictureDir.path}/$filename');
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      return '${pictureDir.path}/$filename';
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
