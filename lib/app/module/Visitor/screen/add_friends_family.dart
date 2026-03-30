import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/difenece_text_style.dart';
import '../../../utils/widgets/camera_screen.dart';
import '../../../utils/widgets/camera_screen_controller.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../controllers/visitors_api_provider.dart';
import '../controllers/visitors_controller.dart';
import '../models/visitors_mobile_list.dart';

class AddFriendsFamily extends StatefulWidget {
  const AddFriendsFamily({super.key});

  @override
  State<AddFriendsFamily> createState() => _AddFriendsFamilyState();
}

class _AddFriendsFamilyState extends State<AddFriendsFamily> {
  final mobile = TextEditingController();
  final selectVisitore = TextEditingController();
  final visitorName = TextEditingController();
  final visitorPhone = TextEditingController();
  final visitorNoOfPerson = TextEditingController();
  final visitorVahicalNo = TextEditingController();
  final visitorFlatNo = TextEditingController();
  final owner = TextEditingController();
  List <File> attachment = [];

  final CameraScreenController cameraController = Get.put(CameraScreenController());
  final VisitorsController visitorsController = Get.put(VisitorsController());

  final List<String> options = ["All", "Visitors", "Vehicles", "Incidents"];
  load()async{
    await cameraController.getCamera();
  }

  @override
  void initState() {
    super.initState();

    load();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return CommenAppBar(
            image: "assets/guard.png",
            name: "Manoj",
            position: "Guard",
            address: "Vision Rytham A wing Gate 1",
            date: "date",
            context: context,
            isBottom: true,
          floatActions: Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: btn(
                      "Cancel",
                      elevateBtn: "elevated",
                      color: Color(0xFF474747),
                      colorText: Colors.white,
                      icon: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),

                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),
                  Expanded(
                    child: btn(
                      "Submit",
                      elevateBtn: "elevated",
                      color: DifeneceColors.appColor,
                      colorText: Colors.white,
                      icon: Icon(Icons.send, color: Colors.white, size: 15),
                      onPressed: (){
                        if(visitorName.text.isEmpty){
                          Get.snackbar("Error", "Please enter visitors name",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: DifeneceColors.appColor,
                            colorText: Colors.white,
                          );
                        }else   if(visitorPhone.text.isEmpty){
                          Get.snackbar("Error", "Please enter visitors number",
                          snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: DifeneceColors.appColor,
                            colorText: Colors.white,
                          );
                        }else  if(visitorNoOfPerson.text.isEmpty){
                          Get.snackbar("Error", "Please enter no of persons",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: DifeneceColors.appColor,
                            colorText: Colors.white,
                          );
                        }else  if(visitorFlatNo.text.isEmpty){
                          Get.snackbar("Error", "Please enter flat no",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: DifeneceColors.appColor,
                            colorText: Colors.white,
                          );
                        }else  if(visitorsController.tenantsOwnerSelected.isEmpty){
                          Get.snackbar("Error", "Please Select tenets/owner",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: DifeneceColors.appColor,
                            colorText: Colors.white,
                          );
                        }else{
                          visitorsController.addVisitors(visitorName.text,
                              visitorPhone.text, visitorNoOfPerson.text, visitorVahicalNo.text, "mano", attachment);
                        }
                      }
                    ),
                  ),
                ],
              ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  authTextFieldRounded(
                      hint: "Flat No.",
                      controller: visitorFlatNo,
                      icon: Icons.search,
                      isSuffix: false,
                      onChanged: (s) async {
                        if(s.isNotEmpty){
                          await visitorsController.getFlatList(s);
                        }
                      }
                  ),

                  visitorsController.isLoadingFlat.value
                      ? authTextFieldRounded(
                      hint: "Loading...",
                      controller: visitorName,
                      icon: Icons.arrow_drop_down,
                      isSuffix: false,
                      readOnly: true
                  ) : authDropRounded(
                      hint: "Select Owner/Tenets",
                      controller: owner,
                      icon: Icons.arrow_drop_down_sharp,
                      isSuffix: false,
                      items: visitorsController.tenantsOwner?.map((value) {
                        return DropdownMenuItem<dynamic>(value: value,
                            child: Text("${value.firstName}")
                        );
                      }).toList()??[],
                      onChanged:  (value) async {
                         visitorsController.tenantsOwnerSelected.clear();
                        visitorsController.tenantsOwnerSelected.add(value);

                      }
                  ),

                  visitorsController.tenantsOwnerSelected.isNotEmpty
                      ? Wrap(
                    spacing: 3,
                    runSpacing: 10,
                    children: List.generate(  visitorsController.tenantsOwnerSelected.length, (index) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: MediaQuery.of(context).size.width / 3,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child:Text(
                                  "${  visitorsController.tenantsOwnerSelected[index].firstName}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: MediaQuery.of(context).size.width / 3,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child:Text(
                                  "${  visitorsController.tenantsOwnerSelected[index].phone}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: MediaQuery.of(context).size.width / 3,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child:Text(
                                  "${  visitorsController.tenantsOwnerSelected[index].block}"
                                      "/${  visitorsController.tenantsOwnerSelected[index].floor}"
                                      "/${  visitorsController.tenantsOwnerSelected[index].flat}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                visitorsController.tenantsOwnerSelected.removeAt(index);
                              },
                              child: Container(
                                // width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                    child:Icon(Icons.close,color: Colors.red,)

                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                      :SizedBox(),

                 //  authTextFieldRounded(
                 //    hint: "Mobile",
                 //    controller: mobile,
                 //    icon: Icons.search,
                 //    isSuffix: true,
                 //    onChanged: (s) async {
                 //      if(s.isNotEmpty){
                 //       await visitorsController.getVisistorsByMobile(s);
                 //      }
                 //    }
                 //  ),
                 //
                 // visitorsController.isLoadingVisitor.value
                 //     ? authTextFieldRounded(
                 //   hint: "Select Visitor",
                 //   controller: visitorName,
                 //   icon: Icons.arrow_drop_down,
                 //   isSuffix: false,
                 //   readOnly: true
                 // ) : authDropRounded(
                 //    hint: "Select Visitor",
                 //    controller: selectVisitore,
                 //    icon: Icons.arrow_drop_down,
                 //    isSuffix: false,
                 //    items: visitorsController.visitorsMobileSearch.value.data?.map((value) {
                 //     return DropdownMenuItem<VisitorsMobile>(value: value,
                 //         child: Text("${value.name}")
                 //     );
                 //   }).toList()??[],
                 //   onChanged:  (value) {
                 //      visitorName.text = value.name??"";
                 //      visitorPhone.text = value.phone?.toString()??"";
                 //
                 //
                 //   }
                 //  ),

                  authTextFieldRounded(
                    hint: "Visitors Name",
                    controller: visitorName,
                    icon: Icons.arrow_drop_down,
                    isSuffix: false,
                  ),

                  authTextFieldRounded(
                    hint: "Visitors Phone no.",
                    controller: visitorPhone,
                    icon: Icons.search,
                    isSuffix: false,
                  ),

                  authTextFieldRounded(
                    hint: "No Of Person",
                    controller: visitorNoOfPerson,
                    icon: Icons.search,
                    isSuffix: false,
                  ),

                  authTextFieldRounded(
                    hint: "Vahical No.",
                    controller: visitorVahicalNo,
                    icon: Icons.search,
                    isSuffix: false,
                  ),


                  SizedBox(height: 10),
                  Wrap(
                    spacing: 3,
                    runSpacing: 10,
                    children: List.generate(  attachment.length, (index) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child:Image.file(attachment[index])
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Permission.camera.request().then((value) async {
                        await  Get.to(CameraScreen());
                        setState(() {
                        });
                        var pickedFile = cameraController.getFile();
                        print("Pikked file ${pickedFile}");
                        if (pickedFile != null) {
                          File f = new File(
                              pickedFile.path);
                          attachment.add(f);
                        } else {
                          setState(() {});
                        }
                      });


                    },
                    child: Container(
                      height: 50,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: BoxBorder.all(color: Color(0xFFC60013)),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.insert_photo_outlined,
                              color: Color(0xFFC60013),
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Upload Visitor Image",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFC60013),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

