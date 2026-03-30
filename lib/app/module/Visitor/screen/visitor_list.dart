import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../stores/rest_apis_urls.dart';
import '../../../utils/difenece_colors.dart';
import '../../../utils/difenece_text_style.dart';
import '../../../utils/helpers/date_format.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../controllers/visitors_controller.dart';
import '../models/visitors_list_model.dart';

class VisitorsList extends StatefulWidget {
  const VisitorsList({super.key});

  @override
  State<VisitorsList> createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  VisitorsController visitorController = Get.put(VisitorsController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 50) {
        visitorController.loadMore();
      }
    });
  }

  load() async {
    await visitorController.getVisitorsList(isRefresh: true);

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
          isBottom: false,
            child:  Container(

                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.74,
                      child: visitorController.isLoading.value
                          ?SizedBox()
                          :visitorController.visitorsListModel.value.data == null
                          || visitorController.visitorsListModel.value.data!.isEmpty
                          ?SizedBox()
                          :RefreshIndicator(
                        onRefresh: visitorController.refreshList,
                        child: Obx(() {
                          final list =
                              visitorController.visitorsListModel.value.data ?? [];

                          return ListView.builder(
                            controller: scrollController,
                            itemCount: list.length +
                                (visitorController.isPaginationLoading.value ? 1 : 0),
                            itemBuilder: (context, index) {
                              // 🔹 Normal Item
                              if (index < list.length) {
                                return _dashboardCard1(list[index]);
                              }

                              // 🔹 Bottom Loader
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

        );
      }
    );
  }
}

// ================= CARD TEMPLATE =================

Widget _dashboardCard1(Visitora visitors) {
  VisitorsController visitorController = Get.put(VisitorsController());


  String selectedValue = "";

  final List<String> items = ["In", "Out", "Return"];
  // selectedValue =visitors.units.isEmpty? : ;

  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 8),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statItem(label: "Name", value: "${visitors.name??"-"}"),
              SizedBox(height: 5),
              _statItem(label: "Mobile", value: "${visitors.phone??"-"}"),
              SizedBox(height: 5),
              _statItem(label: "Nop", value: "${visitors.noOfPersons??"-"}"),
              SizedBox(height: 5),
              _statItem(label: "From", value: "-"),
              SizedBox(height: 5),
              visitors.units.isNotEmpty
                  ? _statItem(label: "Flat", value: "${visitors.units[0].block }/${visitors.units[0].floor }/${visitors.units[0].flat }")
              :_statItem(label: "Flat", value: "-"),
              SizedBox(height: 5),
              visitors.units.isEmpty
                  ? _statItemWidget(
                label: "Status",
                value: "-",
                color: Colors.green,
              ):_statItemWidget(
                label: "Status",
                value: "${visitors.units[0].status}",
                color: visitors.units[0].status == "Exit" || visitors.units[0].status == "Approved"
                ?Colors.green:visitors.units[0].status == "Pending"
                ?Colors.blue:Colors.red,
              ),
              SizedBox(height: 5),
              visitors.units.isEmpty
                  ?_statItemWidget(
                label: "In Status",
                value: "-",
                color: Colors.red,
              ):_statItemWidget(
                label: "In Status",
                value: "${visitors.units[0].inStatus??"-"}",
                color:visitors.units[0].inStatus == "Exit" ?Colors.green : Colors.red,
              ),
              SizedBox(height: 5),
              _statItem(label: "Guard", value: "${visitors.guardName}"),
            ],
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: DifeneceColors.TextDarkColor2,
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: visitors.visitorImage == null
              ?Image.asset("assets/visitorMan.png")
                :Image.network("${RestApisUrls.BASE_URL}${visitors.visitorImage}",
                  fit: BoxFit
                      .fill,
                  // .cover,
                  errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                    return SizedBox();
                  },
                  loadingBuilder: (BuildContext? context, Widget? child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child??SizedBox();
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? (loadingProgress.cumulativeBytesLoaded / double.parse(loadingProgress.expectedTotalBytes!.toString()))
                            : 100.0,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              visitors.units.isNotEmpty && visitors.units[0].status == "Approved"?Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // value: selectedValue,
                        dropdownColor: Colors.grey.shade600,
                        hint: Text("Action",style: TextStyle(
                          color: Colors.white
                        ),),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                const Icon(Icons.crop_square_outlined,
                                    color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) async {
                          await visitorController.updateVisitorsStatuus(visitors.visitorId,
                              visitors.units.isNotEmpty? visitors.units[0].id :"",
                              value
                          );

                        },
                      ),
                    ),
                  )
               :_statItemWidgetButton(
                label: Icons.check_box_outline_blank,
                value: "Out",
                color: DifeneceColors.valueColor,
                text: Colors.white,
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  visitors.units.isEmpty
                      ?_statItemAlignEnd(label: "In Time", value: "-")
                  :_statItemAlignEnd(label: "In Time", value: "${DateFormatter().formatDateToTime(visitors.units[0].inTime.toString())}"),
                  SizedBox(height: 5),
                  visitors.units.isEmpty
                      ?_statItemAlignEnd(label: "Out Time", value: "-")
                      :_statItemAlignEnd(label: "Out Time", value: "${DateFormatter().formatDateToTime(visitors.units[0].outTime.toString())}"),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _statItem({required String label, required String value}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          "$label:",
          style: TextStyle(color: DifeneceColors.labelColor, fontSize: 14),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            color: DifeneceColors.valueColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

Widget _statItemAlignEnd({required String label, required String value}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(
        child: Text(
          "$label:",
          style: TextStyle(color: DifeneceColors.labelColor, fontSize: 12),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            color: DifeneceColors.valueColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

Widget _statItemWidget({
  required String label,
  required String value,
  required Color color,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          "${label}:",
          style: const TextStyle(
            color: DifeneceColors.valueColor,
            fontSize: 14,
          ),
        ),
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color.withOpacity(0.1),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            "${value}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _statItemWidgetButton({
  required IconData label,
  required String value,
  required Color color,
  required Color text,
}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Icon(label, color: text)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "${value}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: text,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
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
