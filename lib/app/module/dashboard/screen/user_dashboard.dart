import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/difenece_text_style.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../../Vahical/screen/add_vahical.dart';
import '../../Vahical/screen/vehicle_list.dart';
import '../../Visitor/screen/add_visitor.dart';
import '../../Visitor/screen/visitor_list.dart';
import '../../incident/screen/add_incident.dart';
import '../../incident/screen/incidentListScreen.dart';
import '../controllers/dashboard_controller.dart';
import '../models/guard_dashboard.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  DashboardController dashboardController = Get.put(DashboardController());
  String dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();

  }

  load() async {
    await dashboardController.getGuardDashboard(dateNow);

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
isDateSelect: true,
            context: context, isBottom: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _dashboardCard1(dashboardController.guardDashbord.value.data?.visitors),
                  const SizedBox(height: 15),
                  _dashboardCard2(dashboardController.guardDashbord.value.data?.vehicles),
                  const SizedBox(height: 15),
                  _dashboardCard3(dashboardController.guardDashbord.value.data?.kids),
                  const SizedBox(height: 15),
                  _dashboardCard4(dashboardController.guardDashbord.value.data?.incidents),
                ],
              ),
            ),
          ),

        );
      }
    );
  }
}

// ================= CARD TEMPLATE =================

Widget _statItem({
  Function()? onPressed,
  required String number,
  required String label,
  required String image,
  required Color color,
}) {
  return Expanded(
    child: InkWell(
      onTap: onPressed ?? () {},
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.1),
            child: SvgPicture.asset(image, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ================= DASHBOARD CARDS =================

Widget _dashboardCard1(Visitors? visitors) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFEFEAEA),
          Color(0xFFFFFFFF), // 0%
          // 100%
        ],
      ),

      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${visitors?.total}",
                    label: "Total Visitors",
                    onPressed: () {
                      Get.to(VisitorsList());
                    },
                    color: Colors.grey,
                    image: 'assets/total_visitor.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "${visitors?.inside}",
                    label: "Inside Visitors",
                    image: "assets/inside_visitor.svg",
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${visitors?.exited}",
                    label: "Exit Visitors",
                    image: "assets/exit_visitor.svg",
                    color: Colors.green,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(AddVisitor());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/exit_visitor.svg",
                            color: Colors.white,
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(width: 4),
                          Text("Add Visitor"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(flex: 1, child: Image.asset("assets/visitorMan.png")),
      ],
    ),
  );
}

Widget _dashboardCard2(Kids? kids) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFFFDBDB),
          Color(0xFFFFFFFF), // 0%
          // 100%
        ],
      ),

      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${kids?.total}",
                    label: "Total Vehicles",
                    onPressed: () {
                      Get.to(VehicalList());
                    },
                    color: Colors.grey,
                    image: 'assets/v_total.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "${kids?.kidsIn}",
                    label: "Inside Vehicles",
                    image: "assets/v_in.svg",
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${kids?.exit}",
                    label: "Vehicles Exit",
                    image: "assets/v_exit.svg",
                    color: Colors.green,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(AddVahical());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/v_exit.svg",
                            color: Colors.white,
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(width: 4),
                          Expanded(child: Text("Entry/Exit")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(flex: 1, child: Image.asset("assets/v_car.png")),
      ],
    ),
  );
}

Widget _dashboardCard3(Kids? kids) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFEFEAEA),
          Color(0xFFFFFFFF), // 0%
          // 100%
        ],
      ),

      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${kids?.total}",
                    label: "Total Kids",
                    color: Colors.grey,
                    image: 'assets/k_total.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "${kids?.kidsIn}",
                    label: "Kids Inside",
                    image: "assets/k_in.svg",
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${kids?.exit}",
                    label: "Kids Exit",
                    image: "assets/k_exit.svg",
                    color: Colors.green,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/k_exit.svg",
                            color: Colors.white,
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(width: 4),
                          Text("Entry/Exit"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(flex: 1, child: Image.asset("assets/kid.png")),
      ],
    ),
  );
}

Widget _dashboardCard4(Incidents? incidents) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFFFF9F9), // 0%
          // 100%
        ],
      ),

      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${incidents?.total}",
                    onPressed: () {
                      Get.to(IncidentList());
                    },
                    label: "Total Incidents",
                    color: Colors.grey,
                    image: 'assets/i_total.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "${incidents?.open}",
                    label: "Open Incidents",
                    image: "assets/i_in.svg",
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    number: "${incidents?.closed}",
                    label: "Closed Incidents",
                    image: "assets/i_exit.svg",
                    color: Colors.green,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(AddIncident());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/i_total.svg",
                            color: Colors.white,
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(width: 4),
                          Expanded(child: Text("Add Incident")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(flex: 1, child: Image.asset("assets/ins.png")),
      ],
    ),
  );
}

Widget _bottomNav() {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(30),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.home, color: Colors.red),
        Icon(Icons.phone_android, color: Colors.white),
        Icon(Icons.person, color: Colors.white),
      ],
    ),
  );
}
