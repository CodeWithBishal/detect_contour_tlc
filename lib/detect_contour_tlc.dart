import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

class CalculateTlcReading {
  static Future<File> fromPath({
    required String imageFile,
  }) async {
    final dylib = Platform.isAndroid
        ? DynamicLibrary.open("libOpenCV_ffi.so")
        : DynamicLibrary.process();
    final imagePath = imageFile.toNativeUtf8();
    final imageFfi = dylib.lookupFunction<Void Function(Pointer<Utf8>),
        void Function(Pointer<Utf8>)>('detect_contour_tlc');
    imageFfi(imagePath);
    return File(imagePath.toDartString());
  }
}
