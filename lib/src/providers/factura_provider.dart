import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class _FacturaProvider {
  
  Future<String> subirFirebase(File foto) async {
    final StorageReference reference = FirebaseStorage.instance.ref().child(p.basename(foto.path));
    final StorageUploadTask task = reference.putFile(foto);
    final StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    print('Respuesta $downloadUrl');
    return downloadUrl;
  }
}

final facturaProvider = _FacturaProvider();