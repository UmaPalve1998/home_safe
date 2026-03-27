import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;


import 'package:get/get.dart';

import '../shared_prefernce.dart';
import 'camera_screen_controller.dart';

// ignore: must_be_immutable
class CameraScreen extends StatefulWidget {
  CameraScreen();

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final CameraScreenController cameraController = Get.put(CameraScreenController());
  late CameraController controller;
  var size;
  var deviceRatio;
  var xScale;
  bool _isRearCameraSelected = true;
  bool torchIcon = false;
  IconData flashIcon = Icons.flash_on_sharp;
  Color flasColor =Colors.white;
  Color offColor =Colors.grey;
  Color autoColor =Colors.grey;
  Color torchColor =Colors.grey;
  Matrix4 transform = Matrix4.diagonal3Values(1, 1.0, 1);
  load()async{
    // await cameraController.getCamera();

    await initCamera(cameraController.cameras![0]);
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(
        cameraController.cameras.value[1],
        ResolutionPreset.veryHigh,
        enableAudio: false
    );
    load();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  File? image;


  Future initCamera(CameraDescription cameraDescription) async {
    controller =CameraController(
        cameraDescription,
        ResolutionPreset.veryHigh,
        enableAudio: false
    );
    String falsh = await SPManager.instance
        .getStringItem('flash');
    if(falsh !=null && falsh.isNotEmpty){
      if(falsh=="off"){
        flashIcon =Icons.flash_off_sharp;
        offColor =Colors.white;
        flasColor =Colors.grey;
        controller.setFlashMode(FlashMode.off);
      }else if(falsh=="auto"){
        flashIcon =Icons.flash_auto;
        autoColor = Colors.white;
        flasColor =Colors.white;
        controller.setFlashMode(FlashMode.always);
      }else if(falsh=="torch"){
        flashIcon =Icons.flash_on;
        torchColor = Colors.white;
        flasColor =Colors.yellow.shade800;
        controller.setFlashMode(FlashMode.torch);
      }


    }else{
      flashIcon =Icons.flash_off_sharp;
      offColor =Colors.white;
      flasColor =Colors.grey;
      controller.setFlashMode(FlashMode.off);
    }
    await controller.initialize().then((_) {
      if (!mounted) {
        return;
      }


      setState(() {});
    });
  }
  bool isLoading = false;

  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }
  File? file;
  Future takePicture() async {
    setState(() {
      isLoading = true;
    });
      if (!controller.value.isInitialized) {
        Get.snackbar(
          "",
          'selectCameraFirst.',
          colorText: Colors.white,
          backgroundColor: Colors.black87,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10.0,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 18.0,
          ),
          borderRadius: 5.0,
        );
        return null;
      }
    final extDir = await getApplicationDocumentsDirectory();
    final dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    String fileName1 = "${DateTime.now().microsecondsSinceEpoch}";
    final filePath = '$dirPath/image_${fileName1.trim()}.jpg';
      if (controller.value.isTakingPicture) {
        // A capture is already pending, do nothing.
        return null;
      }
    String falsh = await SPManager.instance
        .getStringItem('flash');
    if(falsh=="auto"){
      controller.setFlashMode(FlashMode.torch);
    }
    setState(() {

    });
      try {
        XFile xfile = await controller.takePicture();
        if (_isRearCameraSelected == false) {
          Uint8List imageBytes = await xfile.readAsBytes();

          img.Image? originalImage = img.decodeImage(imageBytes);
          img.Image fixedImage = img.flipHorizontal(originalImage!);

          File fileX = File(xfile.path);
          File? fileP = await fileX.writeAsBytes(
            img.encodeJpg(fixedImage),
            flush: true,
          );
          File fileXP = File(fileP.path);
          XFile? filex = await FlutterImageCompress.compressAndGetFile(
            fileXP.absolute.path, filePath,
            quality: 60,
          );
          file = filex != null ? File(filex.path) : File(fileP.path);
        }else{
          // file = File(xfile.path);
          File fileX = File(xfile.path);
          XFile? filex = await FlutterImageCompress.compressAndGetFile(
            fileX.absolute.path, filePath,
            quality: 60,
          );
          file = filex != null ? File(filex.path) : File(xfile.path);
        }
      } on CameraException catch (e) {
        _showCameraException(e);
        return null;
      }

    if(falsh=="auto"){
      controller.setFlashMode(FlashMode.off);
    }
      setState(() {
        isLoading = false;

      });

  }

  void _showCameraException(CameraException e) {
    Get.snackbar(
      "",
      '${e.code}\n${e.description}',
      colorText: Colors.white,
      backgroundColor: Colors.black87,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 18.0,
      ),
      borderRadius: 5.0,
    );
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
        cameraDescription,
        ResolutionPreset.veryHigh,
        enableAudio: false
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        Get.snackbar(
          "",
          '${controller.value.errorDescription}',
          colorText: Colors.white,
          backgroundColor: Colors.black87,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10.0,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 18.0,
          ),
          borderRadius: 5.0,
        );
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final yScale = 1.0;
      size = MediaQuery.of(context).size;
      deviceRatio = size.width / size.height;
      // xScale = controller.value.aspectRatio / deviceRatio;
      xScale = controller.value.isInitialized? controller.value.aspectRatio / deviceRatio : 1.0;

    // Modify the yScale if you are in Landscape

    return Scaffold(
      body: SafeArea(
        child: (controller.value.isInitialized == false)
            ?Container(
          color: Colors.black,
        )
            :file != null
            ?Stack(
          children: [
            Container(
              width:  MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height -250,
              child: Image.file(
                file!,

                fit: BoxFit.cover,
              ),
            ),
            GestureDetector(
                onTap: () {
                },
                child: Container()
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white,width: 1),
                            shape: BoxShape.circle
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: 25,
                          icon: Icon(
                              Icons.close,
                              color: Colors.white),
                          onPressed: () {
                            file = null;
                            setState(() {
                            });
                          },
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                      ),
                    ),

                    Expanded(
                      child:Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white,width: 1),
                            shape: BoxShape.circle
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: 25,
                          icon: Icon(
                              Icons.check,
                              color: Colors.white),
                          onPressed: () {
                            cameraController.addFile( file!);
                            setState(() {});
                            // if ( mpC.pickedFile != null) {
                            //   attachment = new File(
                            //       mpC.pickedFile!.path);
                            //  widget.attach.text = path.basename( mpC.pickedFile!.path);
                            //   setState(() {});
                            // } else {
                            //   setState(() {});
                            // }
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        )
            :isLoading
            ?Stack(
          children: [
            Container(
              width:  MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: deviceRatio,
                child: Transform(
                  alignment: Alignment.center,
                  transform: transform,
                  child: CameraPreview(
                    controller,
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                },
                child: Container()
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Loading..',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: SizedBox(),
              ),
            )

          ],
        )
            :Stack(
          children: [
            Container(
              width:  MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: deviceRatio,
                child: Transform(
                  alignment: Alignment.center,
                  transform: transform,
                  child: CameraPreview(
                    controller,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: !_isRearCameraSelected?Align(
                alignment: Alignment.topCenter,):Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    left: 0.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              iconSize: 25,
                              icon: Icon(
                                  flashIcon,
                                  color: flasColor),
                              onPressed: () {
                                setState(() {
                                  torchIcon = true;
                                });
                              },
                            ),
                          ),
                        ),
                      torchIcon?  Expanded(
                        flex:2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  controller.setFlashMode(FlashMode.off);
                                  await SPManager.instance
                                      .setStringItem('flash',"off");
                                  setState(() {
                                    torchIcon = false;
                                    flashIcon =Icons.flash_off_sharp;
                                    offColor =Colors.white;
                                    torchColor =Colors.grey;
                                    autoColor =Colors.grey;
                                    flasColor =Colors.grey;
                                  });
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                                child: Text(
                                  "Flash Off",
                                  style: TextStyle(
                                      color: offColor, backgroundColor: Colors.transparent),
                                ),
                              ),


                              // **For Flash ON**
                              ElevatedButton(
                                onPressed: () async {
                                  controller.setFlashMode(FlashMode.torch);
                                  await SPManager.instance
                                      .setStringItem('flash',"torch");
                                  setState(() {
                                    torchIcon = false;
                                    flashIcon =Icons.flash_on_sharp;
                                    offColor =Colors.grey;
                                    torchColor =Colors.white;
                                    autoColor =Colors.grey;
                                    flasColor =Colors.yellow.shade800;
                                  });
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                                child: Text(
                                  "Flash On",
                                  style: TextStyle(
                                      color: torchColor, backgroundColor: Colors.transparent),
                                ),
                              ),
                              //**For AUTO Flash:**
                              ElevatedButton(
                                onPressed: () async {
                                  controller.setFlashMode(FlashMode.always);
                                  await SPManager.instance
                                      .setStringItem('flash',"auto");

                                  setState(() {
                                    torchIcon = false;
                                    flashIcon =Icons.flash_auto;
                                    offColor =Colors.grey;
                                    torchColor =Colors.grey;
                                    autoColor =Colors.white;
                                    flasColor =Colors.white;
                                  });
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                                child: Text(
                                  "Auto Flash",
                                  style: TextStyle(
                                      color: autoColor, backgroundColor: Colors.transparent),
                                ),
                              )
                            ],
                          ),
                      ):SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: Row(
                  children: [
                    Expanded(
                      child:Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white,width: 1),
                            shape: BoxShape.circle
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: 25,
                          icon: Icon(
                              Icons.close,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white,width: 4),
                          shape: BoxShape.circle
                        ),
                        child: IconButton(
                          onPressed: () async {
                            await takePicture();

                          },
                          iconSize: 40,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.circle, color: Colors.white),
                        ),
                      ),
                    ),

                    Expanded(
                      child:Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white,width: 1),
                            shape: BoxShape.circle
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: 25,
                          icon: Icon(
                              _isRearCameraSelected
                                  ? CupertinoIcons.switch_camera
                                  : CupertinoIcons.switch_camera_solid,
                              color: Colors.white),
                          onPressed: () {
                            if(_isRearCameraSelected) {
                              transform =Matrix4.diagonal3Values(1, yScale, 1)  ; }else{
                              transform = Matrix4.diagonal3Values(1, yScale, 1);}
                            setState(() => _isRearCameraSelected = !_isRearCameraSelected);
                            initCamera(cameraController.cameras![_isRearCameraSelected ? 0 : 1]);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
