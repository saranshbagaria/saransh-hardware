import 'package:flutter/material.dart';
import 'package:flutter_testing/modules/coupon/coupon_page.dart';
import 'package:flutter_testing/modules/painter/service/painter_service.dart';
import 'package:get/get.dart';
import 'controller/painter_list_controller.dart';

class PainterListPage extends GetView<PainterListController> {
  const PainterListPage({super.key});

  static const String routeName = "/painterListPage";

  static final IPainterService _painterService = PainterService();

  static var painterListController =
      Get.put(PainterListController(_painterService));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (painterListController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (painterListController.painters.isEmpty) {
        return Center(
          child: Text('No Data Available'),
        );
      }
      return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Contact')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: painterListController.painters
                      .map((painter) => DataRow(
                            cells: [
                              DataCell(Text(painter.name)),
                              DataCell(Text(painter.contactNumber)),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        // Handle menu item click
                                        Get.toNamed(value);
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                            value: CouponPage.routeName,
                                            child: Text('Register Coupon'),
                                          ),
                                          PopupMenuItem(
                                            value: 'Delete',
                                            child: Text('Delete'),
                                          ),
                                        ];
                                      },
                                      icon: Icon(
                                          Icons.more_vert), // Three-dot icon
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      .toList()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: painterListController.currentPage.value > 1
                    ? painterListController.goToPreviousPage
                    : null,
                child: Text("Previous"),
              ),
              SizedBox(
                width: 20,
              ),
              Text("Page ${painterListController.currentPage.value}"),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: painterListController.currentPage.value <
                        painterListController.totalPages.value
                    ? painterListController.goToNextPage
                    : null,
                child: Text("Next"),
              ),
            ],
          )
        ],
      );
    });
  }
}
