import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_safe/app/module/kids/controllers/kids_controller.dart';
import 'package:get/get.dart';
import '../../../stores/rest_apis_urls.dart';
import '../../../utils/difenece_colors.dart';
import '../../../utils/difenece_text_style.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../models/kids_search_model.dart';

class AddKids extends StatefulWidget {
  const AddKids({super.key});

  @override
  State<AddKids> createState() => _AddKidsState();
}

class _AddKidsState extends State<AddKids> {
  final searchKidsTxt = TextEditingController();
  final kidsSelect = TextEditingController();
  final ownerTententName = TextEditingController();
  final block = TextEditingController();
  final floor = TextEditingController();
  final flatNo = TextEditingController();
  final ownerNumber = TextEditingController();
  final kidName = TextEditingController();
  final kidsAge = TextEditingController();
  final tendtID = TextEditingController();
  final status = TextEditingController();
  final KidsController kidsController = Get.put(KidsController());
  KidsSearchData? kidsSearchData;
  Resident? resident;
  String? image;
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
                    color: (ownerTententName.text.isEmpty ||
                        ownerNumber.text.isEmpty ||
                        flatNo.text.isEmpty ||
                        floor.text.isEmpty ||
                        status.text.isEmpty ||
                        resident==null ||
                        block.text.isEmpty)
                        ?Color(0xE1BD3B3B)
                        :DifeneceColors.appColor,
                    colorText: Colors.white,
                    icon: Icon(Icons.send, color: Colors.white, size: 15),
                    onPressed:(ownerTententName.text.isEmpty ||
                        ownerNumber.text.isEmpty ||
                        flatNo.text.isEmpty ||
                        floor.text.isEmpty ||
                        resident==null ||
                        status.text.isEmpty||
                        block.text.isEmpty)? (){} : () async {
                      await kidsController.addKid(resident?.name, resident?.age,
                          resident?.gender, ownerTententName.text, ownerNumber.text, block.text,
                          flatNo.text, floor.text, status.text, tendtID.text);

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
                    hint: "Search Name / Flat number",
                    controller: searchKidsTxt,
                    icon: Icons.search,
                    isSuffix: true,

                    onChanged: (s) async {
                      if (s.isNotEmpty) {
                        await kidsController.getKidsSearch(s);
                        print(
                          "response ${kidsController.kidsSearchModel.value.success}",
                        );
                        if (kidsController.kidsSearchModel.value.success == true) {
                          if (kidsController
                                  .kidsSearchModel
                                  .value
                                  .data!
                                  .residents
                                  .length ==
                              1) {
                            ownerTententName.text =
                                kidsController
                                    .kidsSearchModel
                                    .value
                                    .data
                                    ?.firstName ??
                                "";
                            ownerNumber.text =
                                kidsController.kidsSearchModel.value.data?.phone ??
                                "";
                            block.text =
                                kidsController.kidsSearchModel.value.data?.block ??
                                "";
                            floor.text =
                                kidsController.kidsSearchModel.value.data?.floor ??
                                "";
                            flatNo.text =
                                kidsController.kidsSearchModel.value.data?.flat ??
                                "";
                            tendtID.text = kidsController.kidsSearchModel.value.data?.tenantId??"";
                            resident = kidsController
                                .kidsSearchModel
                                .value
                                .data
                                ?.residents[0];
                            setState(() {});
                          } else {
                            kidsSearchData =
                                kidsController.kidsSearchModel.value.data;
                            ownerTententName.text = "";
                            ownerNumber.text = "";
                            block.text = "";
                            floor.text = "";
                            flatNo.text = "";
                            setState(() {});
                          }
                        } else {
                          print("isEmpty");
                          ownerTententName.text = "";
                          ownerNumber.text = "";
                          block.text = "";
                          floor.text = "";
                          flatNo.text = "";
                          kidsSearchData = null;
                          resident = null;
                          setState(() {});
                        }
                      } else {
                        print("isEmpty");
                        ownerTententName.text = "";
                        ownerNumber.text = "";
                        block.text = "";
                        floor.text = "";
                        flatNo.text = "";
                        kidsSearchData = null;
                        resident = null;
                        setState(() {});
                      }
                    },
                  ),

                  kidsController.isLoadingKids.value
                      ? authTextFieldRounded(
                          hint: "Loading...",
                          controller: kidsSelect,
                          icon: Icons.arrow_drop_down,
                          isSuffix: false,
                          readOnly: true,
                        )
                      : kidsSearchData == null ||
                            kidsSearchData!.residents.length <= 1
                      ? SizedBox()
                      : authDropRounded(
                          hint: "Select Kids",
                          controller: kidsSelect,
                          icon: Icons.arrow_drop_down_sharp,
                          isSuffix: false,
                          items:
                              kidsSearchData?.residents?.map((value) {
                                return DropdownMenuItem<Resident>(
                                  value: value,
                                  child: Text("${value.name}"),
                                );
                              }).toList() ??
                              [],
                          onChanged: (value) async {
                            ownerTententName.text = kidsSearchData?.firstName ?? "";
                            ownerNumber.text = kidsSearchData?.phone ?? "";
                            tendtID.text = kidsSearchData?.tenantId??"";

                            block.text = kidsSearchData?.block ?? "";
                            floor.text = kidsSearchData?.floor ?? "";
                            flatNo.text = kidsSearchData?.flat ?? "";
                            resident = value;
                            setState(() {});
                          },
                        ),

                  resident == null || resident!.residentImage == null
                      ? SizedBox()
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: DifeneceColors.TextDarkColor2,
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Image.network(
                            "${RestApisUrls.BASE_URL}${resident!.residentImage}",
                            fit: BoxFit.fill,
                            // .cover,
                            errorBuilder:
                                (
                                  BuildContext? context,
                                  Object? exception,
                                  StackTrace? stackTrace,
                                ) {
                                  return SizedBox();
                                },
                            loadingBuilder:
                                (
                                  BuildContext? context,
                                  Widget? child,
                                  ImageChunkEvent? loadingProgress,
                                ) {
                                  if (loadingProgress == null)
                                    return child ?? SizedBox();
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes != null
                                          ? (loadingProgress.cumulativeBytesLoaded /
                                                double.parse(
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                                      .toString(),
                                                ))
                                          : 100.0,
                                    ),
                                  );
                                },
                          ),
                        ),

                  authTextFieldRounded(
                    hint: "Owner Name",
                    controller: ownerTententName,
                    icon: Icons.arrow_drop_down,
                    isSuffix: false,
                    readOnly: true,
                  ),
                  authTextFieldRounded(
                    hint: "Owner Phone",
                    controller: ownerNumber,
                    icon: Icons.arrow_drop_down,
                    isSuffix: false,
                    readOnly: true,
                  ),
                  Wrap(
                    spacing: 3,
                    runSpacing: 10,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: authTextFieldRounded(
                              hint: "Block",
                              controller: block,
                              icon: Icons.arrow_drop_down,
                              isSuffix: false,
                              readOnly: true,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: authTextFieldRounded(
                              hint: "Floor",
                              controller: floor,
                              icon: Icons.arrow_drop_down,
                              isSuffix: false,
                              readOnly: true,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: authTextFieldRounded(
                              hint: "Flat Number",
                              controller: flatNo,
                              icon: Icons.arrow_drop_down,
                              isSuffix: false,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  resident != null
                      ? Wrap(
                          spacing: 3,
                          runSpacing: 10,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    // width: MediaQuery.of(context).size.width / 3,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${resident?.name}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    // width: MediaQuery.of(context).size.width / 3,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${resident?.age}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    // width: MediaQuery.of(context).size.width / 3,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${resident?.gender}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                  authDropRounded(
                    hint: "Select Status",
                    controller: status,
                    icon: Icons.arrow_drop_down_sharp,
                    isSuffix: false,
                    items:
                        ["In", "Out"].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text("${value}"),
                          );
                        }).toList() ??
                        [],
                    onChanged: (value) {
                      setState(() {
                        status.text = value;
                      });
                    },
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


