import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_safe/app/module/Vahical/controllers/Vehicle_controller.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/difenece_text_style.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';

class AddVahical extends StatefulWidget {
  const AddVahical({super.key});

  @override
  State<AddVahical> createState() => _AddVahicalState();
}

class _AddVahicalState extends State<AddVahical> {
  final searchVahical = TextEditingController();
  final vNumber = TextEditingController();
  final color = TextEditingController();
  final type = TextEditingController();
  final noOfWheeler = TextEditingController();
  final ownerName = TextEditingController();
  final ownerNumber = TextEditingController();
  final ownerFlat = TextEditingController();
  final ownerBlock = TextEditingController();
  final ownerFloor = TextEditingController();
  final status = TextEditingController();
  final ownerId = TextEditingController();

  VahicleController vahicleController =Get.put(VahicleController());

  final List<String> options = ["All", "Visitors", "Vehicles", "Incidents"];
  @override
  Widget build(BuildContext context) {
    // return  Obx(() {
        return CommenAppBar(
          image: "assets/guard.png",
          name: "Manoj",
          position: "Guard",
          address: "Vision Rytham A wing Gate 1",
          date: "date",
          context: context,
          isBottom: true,
          floatActions: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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

                      child: Icon(Icons.close, color: Colors.black, size: 15),
                    ),
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: btn(
                    "Submit",
                    elevateBtn: "elevated",
                    color: (ownerName.text.isEmpty ||
                        ownerNumber.text.isEmpty ||
                        ownerFlat.text.isEmpty ||
                        vNumber.text.isEmpty ||
                        color.text.isEmpty ||
                        noOfWheeler.text.isEmpty ||
                        status.text.isEmpty ||
                        ownerBlock.text.isEmpty ||
                        ownerFlat.text.isEmpty ||
                        type.text.isEmpty)
                        ?Color(0xE1BD3B3B)
                        :DifeneceColors.appColor,
                    colorText: Colors.white,
                    icon: Icon(Icons.send, color: Colors.white, size: 15),
                    onPressed:(ownerName.text.isEmpty ||
                        ownerNumber.text.isEmpty ||
                        ownerFlat.text.isEmpty ||
                        vNumber.text.isEmpty ||
                        color.text.isEmpty ||
                        noOfWheeler.text.isEmpty ||
                        status.text.isEmpty ||
                        ownerBlock.text.isEmpty ||
                        ownerFlat.text.isEmpty ||
                        type.text.isEmpty)
                        ? (){}
                        : () async {
                      await vahicleController.addVehicle(vNumber.text,
                          ownerName.text,
                          ownerNumber.text,
                          ownerBlock.text,
                          ownerFloor.text,
                          ownerFlat.text, status.text, ownerId.text);

                    },
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
                    hint: "Vehicle No (Last Digits)",
                    controller: searchVahical,
                    icon: Icons.search,
                    isSuffix: true,
                    onChanged: (s) async {
                      if (s.isNotEmpty) {
                        await vahicleController.getKidsSearch(s);
                        print(
                          "response ${vahicleController.vehicleSearchModel.value.success}",
                        );
                        if (vahicleController.vehicleSearchModel.value.success == true) {
                          if (vahicleController.vehicleSearchModel.value.data!.length > 0) {

                            vNumber.text = vahicleController.vehicleSearchModel.value.data?[0].vehicleNo ?? "";
                            color.text = vahicleController.vehicleSearchModel.value.data?[0].vehicleColor ?? "";
                            type.text = vahicleController.vehicleSearchModel.value.data?[0].vehicleModel ?? "";
                            noOfWheeler.text = vahicleController.vehicleSearchModel.value.data?[0].vehicleType ?? "";
                            ownerName.text = vahicleController.vehicleSearchModel.value.data?[0].name ?? "";
                            ownerNumber.text = vahicleController.vehicleSearchModel.value.data?[0].phone ?? "";
                            ownerFlat.text = vahicleController.vehicleSearchModel.value.data?[0].flat ?? "";
                            ownerBlock.text = vahicleController.vehicleSearchModel.value.data?[0].block ?? "";
                            ownerFloor.text = vahicleController.vehicleSearchModel.value.data?[0].floor ?? "";
                            ownerId.text = vahicleController.vehicleSearchModel.value.data?[0].ownerId ?? "";

                          } else {
                            vNumber.text =  "";
                            color.text =  "";
                            type.text =  "";
                            noOfWheeler.text =  "";
                            ownerName.text =  "";
                            ownerNumber.text =  "";
                            ownerFlat.text =  "";
                            ownerBlock.text =  "";
                            ownerFloor.text =  "";
                            ownerId.text =  "";
                            setState(() {});
                          }
                        } else {
                          print("isEmpty");
                          vNumber.text =  "";
                          color.text =  "";
                          type.text =  "";
                          noOfWheeler.text =  "";
                          ownerName.text =  "";
                          ownerNumber.text =  "";
                          ownerFlat.text =  "";
                          ownerBlock.text =  "";
                          ownerFloor.text =  "";
                          ownerId.text =  "";
                          setState(() {});
                        }
                      } else {
                        vNumber.text =  "";
                        color.text =  "";
                        type.text =  "";
                        noOfWheeler.text =  "";
                        ownerName.text =  "";
                        ownerNumber.text =  "";
                        ownerFlat.text =  "";
                        ownerBlock.text =  "";
                        ownerFloor.text =  "";
                        ownerId.text =  "";
                        setState(() {});
                      }
                    },
                  ),


                  authTextFieldRounded(
                    hint: "Vehicle Number",
                    controller: vNumber,
                    icon: Icons.arrow_drop_down,
                    isSuffix: false,
                    readOnly: true
                  ),

                  authTextFieldRounded(
                    hint: "Vehicle Color",
                    controller: color,
                    icon: Icons.search,
                    isSuffix: false,
                      readOnly: true
                  ),

                  authTextFieldRounded(
                    hint: "Vehicle Model",
                    controller: type,
                    icon: Icons.search,
                    isSuffix: false,
                      readOnly: true
                  ),

                  authTextFieldRounded(
                    hint: "Vehicle No Wheeler.",
                    controller: noOfWheeler,
                    icon: Icons.search,
                    isSuffix: false,
                      readOnly: true
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: authTextFieldRounded(
                          hint: "Owner Name",
                          controller: ownerName,
                          icon: Icons.search,
                          isSuffix: false,
                            readOnly: true
                        ),
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: authTextFieldRounded(
                          hint: "Owner Number",
                          controller: ownerNumber,
                          icon: Icons.search,
                          isSuffix: false,
                            readOnly: true
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: authTextFieldRounded(
                          hint: "Block",
                          controller: ownerBlock,
                          icon: Icons.search,
                          isSuffix: false,
                            readOnly: true
                        ),
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: authTextFieldRounded(
                          hint: "Owner floor",
                          controller: ownerFloor,
                          icon: Icons.search,
                          isSuffix: false,
                            readOnly: true
                        ),
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: authTextFieldRounded(
                          hint: "Owner Flat",
                          controller: ownerFlat,
                          icon: Icons.search,
                          isSuffix: false,
                            readOnly: true
                        ),
                      ),
                    ],
                  ),

                  authDropRounded(
                    hint: "Select In/Exit.",
                    controller: status,
                    icon: Icons.arrow_drop_down_sharp,
                    isSuffix: false,
                    items: ["In", "Exit"].map((value) {
                      return DropdownMenuItem<dynamic>(value: value,
                          child: Text("${value}")
                      );
                    }).toList()??[],
                    onChanged:  (value) {
                      status.text = value;
                      setState(() {

                      });


                    },
                  ),


                ],
              ),
            ),
          ),
        );
    //   }
    // );
  }
}
