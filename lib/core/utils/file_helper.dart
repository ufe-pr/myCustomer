import 'package:path_provider/path_provider.dart';

/// 
abstract class FileHelper {
  Future<String> getApplicationDocumentsDirectoryPath();
}

class FileHelperImpl implements FileHelper {
  @override
  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
