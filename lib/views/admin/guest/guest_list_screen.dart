import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/guest/guest_list_controller.dart';
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
import 'package:sikilap/images.dart';
import 'package:sikilap/views/layout/layout.dart';

class GuestListScreen extends StatefulWidget {
  const GuestListScreen({super.key});

  @override
  State<GuestListScreen> createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> with UIMixin {
  GuestListController controller = Get.put(GuestListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'guest_list_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "List Mitra",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'List Mitra', active: true),
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
                      MyText.bodyMedium("Mitra", fontWeight: 600),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            dataRowMaxHeight: 60,
                            columnSpacing: 62,
                            showBottomBorder: false,
                            showCheckboxColumn: true,
                            border: TableBorder.all(style: BorderStyle.solid, width: .4, color: Colors.grey),
                            columns: [
                              DataColumn(label: MyText.bodySmall('Nama Mitra', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Nomor Telepon', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Area Layanan', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Rating', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Status', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Tanggal Gabung', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Aksi', fontWeight: 600)),
                            ],
                            rows: controller.guest
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        DataCell(
                                          Row(
                                            children: [
                                              MyContainer.rounded(
                                                height: 32,
                                                width: 32,
                                                paddingAll: 0,
                                                child: Image.asset(
                                                  Images.avatars[index % Images.avatars.length],
                                                ),
                                              ),
                                              MySpacing.width(12),
                                              MyText.labelSmall(data.name),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.mail, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.email),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.user, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall("${data.age}"),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.map_pin, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.destination),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.calendar, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.arrivalDate),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.calendar, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.departureDate),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.users, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall("${data.numberOfGuest}"),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Icon(LucideIcons.file_text, size: 16),
                                              MySpacing.width(8),
                                              MyText.labelSmall(data.specialRequest),
                                            ],
                                          ),
                                        ),
                                        DataCell(Row(
                                          children: [
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.editGuest,
                                                color: contentTheme.primary.withValues(alpha: .5),
                                                splashColor: contentTheme.background,
                                                borderRadiusAll: 100,
                                                child: Icon(LucideIcons.pencil, size: 12, color: contentTheme.primary)),
                                            MySpacing.width(8),
                                            MyContainer.rounded(
                                                paddingAll: 12,
                                                onTap: controller.addGuest,
                                                color: contentTheme.secondary.withValues(alpha: .5),
                                                splashColor: contentTheme.background,
                                                borderRadiusAll: 100,
                                                child: Icon(LucideIcons.plus, size: 12, color: contentTheme.secondary)),
                                          ],
                                        ))
                                      ],
                                    ))
                                .toList()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
