import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/difenece_text_style.dart';
import '../../../utils/helpers/date_format.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../../../utils/widgets/image_Detailview_widget.dart';
import '../controllers/incident_controller.dart';
import '../models/incident_model.dart';

class IncidentList extends StatefulWidget {
  const IncidentList({super.key});

  @override
  State<IncidentList> createState() => _IncidentListState();
}

class _IncidentListState extends State<IncidentList> {
  final ScrollController scrollController = ScrollController();
  IncidentController incidentController = Get.put(IncidentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 50) {
        incidentController.loadMore();
      }
    });
  }

  load() async {
    await incidentController.getIncidentList(isRefresh: true);

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
                child: incidentController.isLoading.value
                    ?SizedBox()
                    :incidentController.incidentListModel.value.data == null
                    || incidentController.incidentListModel.value.data!.isEmpty
                    ?SizedBox()
                    :RefreshIndicator(
                  onRefresh: incidentController.refreshList,
                  child: Obx(() {
                    final list =
                        incidentController.incidentListModel.value.data ?? [];

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: list.length +
                          (incidentController.isPaginationLoading.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        // 🔹 Normal Item
                        if (index < list.length) {
                          return _dashboardCard1(list[index],context);
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

Widget _dashboardCard1(Incident incident,BuildContext context) {
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
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statItem(label: "Type", value: "${incident.incidentType}"),
                  SizedBox(height: 5),
                  _statItem(label: "Subject", value: "${incident.subject}"),
                  SizedBox(height: 5),
                  _statItem(label: "Date", value: "${DateFormatter().convertToDisplayFormat(incident.date.toString())}"),
                  SizedBox(height: 5),
                  _statItem(label: "Time", value: "${DateFormatter().formatDateToTime(incident.incidentTime.toString())}"),
                  SizedBox(height: 5),
                  _statItem(label: "Close Time", value: "${DateFormatter().formatDateToTime(incident.closeTime.toString())}"),
                  SizedBox(height: 5),
                  _statItemWidget(
                    label: "Status",
                    value: "${incident.status}",
                    color:  incident.status == "Closed" ?Colors.green : Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ImageDetailviewWidget(images: incident.images,);
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: DifeneceColors.GreyColor,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_rounded,
                            size: 45,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "View Images",
                                  style: const TextStyle(
                                    color: DifeneceColors.WhiteColor,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                "${incident.description}",
                style: TextStyle(
                  color: DifeneceColors.appColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(
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

