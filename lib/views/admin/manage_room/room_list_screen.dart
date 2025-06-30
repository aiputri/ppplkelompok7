import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/manage_room/room_list_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_list_extension.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> with UIMixin {
  RoomListController controller = Get.put(RoomListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'room_list_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Room List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Room List', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard(
                  shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                  paddingAll: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText.bodyMedium("Room List"),
                          MyContainer(
                            paddingAll: 8,
                            onTap: controller.gotoAddRoom,
                            color: contentTheme.primary,
                            child: MyText.labelSmall("Add Room", color: contentTheme.onPrimary),
                          )
                        ],
                      ),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            dataRowMaxHeight: 60,
                            columnSpacing: 132,
                            showBottomBorder: false,
                            showCheckboxColumn: true,
                            border: TableBorder.all(style: BorderStyle.solid, width: .4, color: Colors.grey),
                            columns: [
                              DataColumn(label: MyText.bodySmall('Room Type', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Bed Type', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Capacity', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('View', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Floor', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Price', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Action', fontWeight: 600)),
                            ],
                            rows: controller.room
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        DataCell(Row(
                                          children: [
                                            MyContainer(
                                              paddingAll: 0,
                                              height: 48,
                                              width: 48,
                                              child: Image.asset(data.image),
                                            ),
                                            MySpacing.width(24),
                                            MyText.labelSmall(data.roomType),
                                          ],
                                        )),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.bed, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.bedType),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.user, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.capacity.toString()),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.eye, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.view),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.layers, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.floor.toString()),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.dollar_sign, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall("\$${data.pricePerNight} price per night"),
                                            ],
                                          ),
                                        ),
                                        DataCell(Row(
                                          children: [
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.editRoom,
                                                color: contentTheme.primary.withValues(alpha: .5),
                                                splashColor: contentTheme.background,
                                                borderRadiusAll: 100,
                                                child: Icon(LucideIcons.pencil, size: 12, color: contentTheme.primary)),
                                            MySpacing.width(8),
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.roomDetail,
                                                color: contentTheme.secondary.withValues(alpha: .5),
                                                splashColor: contentTheme.background,
                                                borderRadiusAll: 100,
                                                child: Icon(LucideIcons.eye, size: 12, color: contentTheme.secondary)),
                                          ],
                                        ))
                                      ],
                                    ))
                                .toList()),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
