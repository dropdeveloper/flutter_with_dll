import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;

// FFI signature of the hello_world C function
typedef HelloWorldFunc = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();

void main() {
  // Open the dynamic library
  var libraryPath = path.join(Directory.current.path, 'hello_library', 'libhello.so');

  if (Platform.isMacOS) {
    libraryPath = path.join(Directory.current.path, 'hello_library', 'libhello.dylib');
  }

  if (Platform.isWindows) {
    libraryPath = path.join(Directory.current.path, 'hello_library', 'Debug', 'WiFiConnection.dll');
  }

  final dylib = ffi.DynamicLibrary.open(libraryPath);

  // Look up the C function 'hello_world'
  final HelloWorld hello = dylib.lookup<NativeFunction<HelloWorldFunc>>('scanSSID').asFunction();
  // Call the function
  hello();

  // final int Function(int __oflag, int __ext) nativeCodeOpenFun = dylib.lookup<NativeFunction<Int32 Function(Int32, Int32)>>("open").asFunction();

  // int x = nativeCodeOpenFun(3, 3);
}
