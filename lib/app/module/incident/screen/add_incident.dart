import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/difenece_text_style.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';

class AddIncident extends StatefulWidget {
  const AddIncident({super.key});

  @override
  State<AddIncident> createState() => _AddIncidentState();
}

class _AddIncidentState extends State<AddIncident> {
  final incidentType = TextEditingController();
  final subject = TextEditingController();
  final description = TextEditingController();
  final priority = TextEditingController();
  final status = TextEditingController();
  final List<String> options = ["All", "Visitors", "Vehicles", "Incidents"];
  @override
  Widget build(BuildContext context) {
    return CommenAppBar(
        image: "assets/guard.png",
        name: "Manoj",
        position: "Guard",
        address: "Vision Rytham A wing Gate 1",
        date: "date",
        context: context,
        isBottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              authDropRounded(
                hint: "Select Incident type",
                controller: incidentType,
                icon: Icons.arrow_drop_down,
                isSuffix: false,
                items: ["V1", "v2"].map((value) {
                  return DropdownMenuItem<dynamic>(value: value,
                      child: Text("${value}")
                  );
                }).toList()??[],
                onChanged:  (value) {


                },
              ),

              authTextFieldRounded(
                hint: "Subject",
                controller: subject,
                icon: Icons.arrow_drop_down,
                isSuffix: false,
              ),

              authTextFieldRounded(
                hint: "Description",
                controller: description,
                icon: Icons.search,
                multiline: true,
                isSuffix: false,
              ),

              authDropRounded(
                hint: "Select Priority",
                controller: priority,
                icon: Icons.search,
                isSuffix: false,
                items: ["V1", "v2"].map((value) {
                  return DropdownMenuItem<dynamic>(value: value,
                      child: Text("${value}")
                  );
                }).toList()??[],
                onChanged:  (value) {


                },
              ),

              authDropRounded(
                hint: "Select Status",
                controller: status,
                icon: Icons.search,
                isSuffix: false,
                items: ["V1", "v2"].map((value) {
                  return DropdownMenuItem<dynamic>(value: value,
                      child: Text("${value}")
                  );
                }).toList()??[],
                onChanged:  (value) {


                },
              ),

              SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
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

              SizedBox(height: 30),
              Row(
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= CARD TEMPLATE =================

Widget _statItem({
  required String number,
  required String label,
  required String image,
  required Color color,
}) {
  return Expanded(
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
  );
}

// ================= DASHBOARD CARDS =================

Widget _dashboardCard1() {
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
                    number: "99",
                    label: "Total Visitors",
                    color: Colors.grey,
                    image: 'assets/total_visitor.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "10",
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
                    number: "89",
                    label: "Exit Visitors",
                    image: "assets/exit_visitor.svg",
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

Widget _dashboardCard2() {
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
                    number: "99",
                    label: "Total Vehicles",
                    color: Colors.grey,
                    image: 'assets/v_total.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "10",
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
                    number: "89",
                    label: "Vehicles Exit",
                    image: "assets/v_exit.svg",
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

Widget _dashboardCard3() {
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
                    number: "99",
                    label: "Total Kids",
                    color: Colors.grey,
                    image: 'assets/k_total.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "10",
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
                    number: "89",
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

Widget _dashboardCard4() {
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
                    number: "99",
                    label: "Total Incidents",
                    color: Colors.grey,
                    image: 'assets/i_total.svg',
                  ),
                  SizedBox(width: 20),
                  _statItem(
                    number: "10",
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
                    number: "89",
                    label: "Closed Incidents",
                    image: "assets/i_exit.svg",
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
                            "assets/i_total.svg",
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
        Expanded(flex: 1, child: Image.asset("assets/ins.png")),
      ],
    ),
  );
}


