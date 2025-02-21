import 'dart:io';

// import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:saver_gallery/saver_gallery.dart';

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
  // bool? imageIsSaved =
  final result = await SaverGallery.saveFile(
      filePath: url,
      fileName: url.split('/').length >= 1
          ? url.split('/').last
          : DateTime.now().toString() + '.jpg',
      skipIfExists: true);
  return Future(() =>
      result.isSuccess); //return false if no bool was returned from the library
}

Future<void> shareNetworkImage(String url) async {
  Response response = await get(Uri.parse(url));
  List<String> urlPieces = url.split('/');
  var documentDirectory = await getApplicationDocumentsDirectory();
  File file = new File(join(documentDirectory.path, '${urlPieces.last}'));
  await file.writeAsBytes(response.bodyBytes);
  Share.shareXFiles([XFile(file.path)], text: 'Check out this astronomy photo!')
      .then((_) => file.delete());
  // Deleting the file after sharing it because the user did not ask to download, only share it
}
