import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_safe/app/module/Vahical/models/vehicle_list_model.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/difenece_text_style.dart';
import '../../../utils/helpers/date_format.dart';
import '../../../utils/widgets/commen_appBar.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../controllers/Vehicle_controller.dart';

class VehicalList extends StatefulWidget {
  const VehicalList({super.key});

  @override
  State<VehicalList> createState() => _VehicalListState();
}

class _VehicalListState extends State<VehicalList> {
  final ScrollController scrollController = ScrollController();
  VahicleController visitorController = Get.put(VahicleController());

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
    await visitorController.getVehicleList(isRefresh: true);

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
                    :visitorController.vehicleListModel.value.data == null
                    || visitorController.vehicleListModel.value.data!.isEmpty
                    ?SizedBox()
                    :RefreshIndicator(
                  onRefresh: visitorController.refreshList,
                  child: Obx(() {
                    final list =
                        visitorController.vehicleListModel.value.data ?? [];

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

Widget _dashboardCard1(Vehicle vahicle) {
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
              _statItem(label: "Name", value: "${vahicle.name??"-"}"),
              SizedBox(height: 5),
              _statItem(label: "Mobile", value: "${vahicle.phone??"_"}"),
              SizedBox(height: 5),
              _statItem(label: "Vehicle Number", value: "${vahicle.vehicleNo}"),
              SizedBox(height: 5),
              _statItem(label: "Flat", value: "${vahicle.block}/${vahicle.floor}/${vahicle.flat}"),
              SizedBox(height: 5),
              _statItem(label: "Guard", value: "${vahicle.guardName}"),
              SizedBox(height: 5),
              _statItemWidget(
                label: "In Status",
                value: "${vahicle.status}",
                color: vahicle.status == "Out" ?Colors.green : Colors.red,
              ),
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
                child: Image.asset("assets/v_car.png"),
              ),
              SizedBox(height: 5),
              _statItemWidgetButton(
                label: Icons.access_time_sharp,
                value: "${DateFormatter().formatDateToTime(vahicle.time.toString())}",
                text: DifeneceColors.valueColor,
                color: Colors.transparent,
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
