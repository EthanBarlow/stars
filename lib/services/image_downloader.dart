import 'dart:io';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// Future<bool> downloadNetworkImage(String url) async {
//   Response response = await get(Uri.parse(url));
//   List<String> urlPieces = url.split('/');
//   var documentDirectory = await getApplicationDocumentsDirectory();
//   File file = new File(join(documentDirectory.path, '${urlPieces.last}'));
//   print(file.path);
//   await file.writeAsBytes(response.bodyBytes);
//   await GallerySaver.saveImage(file.path);
//   await file.delete();

//   return Future(() {
//     return true;
//   });
// }

Future<bool> downloadNetworkImage(String url) async {
  // TODO: revisit this method for security. Should I sanitize the url before making a network call to it? ... probably
  bool? imageIsSaved = await GallerySaver.saveImage(url);
  return Future(() => imageIsSaved ?? false); //return false if no bool was returned from the library
}
