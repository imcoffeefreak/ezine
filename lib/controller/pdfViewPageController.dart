import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewPageController extends ChangeNotifier {
  File file;
  String path;

  PdfViewPageController({String url}) {
    if(url!=null){
      loadPdf(url);
    }
  }

  void loadPdf(String fileLink) async {
    final url = "$fileLink";
    final RegExp regex =
        RegExp('([^?/]*\.(pdf|jpg|txt|docx|zip|jpeg|png|csv))');
    var filename = regex.stringMatch(fileLink);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    notifyListeners();
    getPath();
  }

  void getPath(){
    path = file.path;
    print("*************** PATH CONTROLLER $path");
    notifyListeners();
  }



}
