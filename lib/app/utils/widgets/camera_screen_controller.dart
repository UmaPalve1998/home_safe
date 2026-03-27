import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';


class CameraScreenController extends GetxController {
  File? pickedFile;
  var cameras=<CameraDescription>[].obs;

  @override
  void onInit()async {
    getCamera();
    super.onInit();
  }

  addFile(File file){
    pickedFile = file;
    update();
  }

  Future<void> getCamera ()async {
    cameras.value = await availableCameras();
    print("avail cam ${cameras.value}");
    update();
  }
  File? getFile(){
    return pickedFile;
  }


}
