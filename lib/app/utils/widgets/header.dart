import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../module/dashboard/controllers/dashboard_controller.dart';
import 'package:intl/intl.dart';
import '../difenece_colors.dart';
import '../helpers/flutter_navigation.dart';
import 'global_widgets.dart';

class Header extends StatefulWidget {
  final String image;
  final String name;
  final String position;
  final String address;
  final String date;
  final bool? isDateSelect;
  const Header({
    super.key,
    required this.image,
    required this.name,
    required this.position,
    required this.address,
    required this.date,
    this.isDateSelect,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(height: 100, child: Image.asset(widget.image)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${widget.name}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("${widget.position}", style: TextStyle(color: Colors.grey)),
              Text("${widget.address}", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("logout"),
                              content: const Text(
                                "Are you sure do you want to logout?",
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: btn(
                                        "Cancel",
                                        onPressed: () {
                                          Get.back();
                                        },
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
                                        "YES",
                                        onPressed: () {
                                          logout(context);
                                        },
                                        elevateBtn: "elevated",
                                        color: DifeneceColors.appColor,
                                        colorText: Colors.white,
                                        icon: Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFC60013), // 0
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: widget.isDateSelect == true? () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );

            if (pickedDate != null) {
              print("Selected Date: $pickedDate");
              dashboardController.uniDate.value = pickedDate;
              dashboardController.getGuardDashboard(DateFormat("yyyy-MM-dd").format(pickedDate));


            }
          }:(){},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFC60013),
                  child: Text(
                    "${dashboardController.uniDate.value.day}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 4),
                 Text(
                  "${ DateFormat('EEEE').format(dashboardController.uniDate.value)}",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
