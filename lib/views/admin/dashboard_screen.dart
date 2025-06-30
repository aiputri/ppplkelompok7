import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikilap/controller/admin/dashboard_controller.dart';
import 'package:sikilap/helpers/theme/app_themes.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_flex.dart';
import 'package:sikilap/helpers/widgets/my_flex_item.dart';
import 'package:sikilap/helpers/widgets/my_list_extension.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/images.dart';
import 'package:sikilap/model/chart_model.dart';
import 'package:sikilap/views/layout/layout.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with UIMixin {
  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
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
                      "Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Dashboard', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Visits", "20.3K", LucideIcons.house, Colors.blue)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Sales", "8.2K", LucideIcons.shopping_cart, Colors.cyan)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Revenue", "\$150K", LucideIcons.dollar_sign, Colors.teal)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Users", "45.7K", LucideIcons.users, Colors.indigo)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Conversion Rate", "5.8%", LucideIcons.chart_bar, Colors.purple)),
                  MyFlexItem(sizes: 'lg-6', child: monthlyAnalytics()),
                  MyFlexItem(sizes: 'lg-6', child: worldMap()),
                  MyFlexItem(child: booking()),
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  Widget stats(String title, String subTitle, IconData icon, Color color) {
    return MyContainer(
      paddingAll: 24,
      color: color.withValues(alpha: 0.1),
      child: Row(
        children: [
          MyContainer(
            paddingAll: 16,
            color: color,
            child: Icon(icon, color: contentTheme.light),
          ),
          MySpacing.width(24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title, fontWeight: 600, xMuted: true, maxLines: 1),
                MySpacing.height(4),
                MyText.titleLarge(subTitle, fontWeight: 600, color: color, maxLines: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget monthlyAnalytics() {
    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 400,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: MyText.bodyMedium("Monthly Analytics", overflow: TextOverflow.ellipsis, fontWeight: 600)),
              PopupMenuButton(
                onSelected: controller.onSelectedTimeByLocation,
                itemBuilder: (BuildContext context) {
                  return ["Year", "Month", "Week", "Day", "Hours"].map((behavior) {
                    return PopupMenuItem(
                      value: behavior,
                      height: 32,
                      child: MyText.bodySmall(
                        behavior.toString(),
                        color: theme.colorScheme.onSurface,
                        fontWeight: 600,
                      ),
                    );
                  }).toList();
                },
                color: theme.cardTheme.color,
                child: MyContainer.bordered(
                  padding: MySpacing.xy(8, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyText.labelSmall(controller.selectedTimeByLocation.toString(), color: theme.colorScheme.onSurface),
                      Icon(LucideIcons.chevron_down, size: 16, color: theme.colorScheme.onSurface)
                    ],
                  ),
                ),
              ),
            ],
          ),
          MySpacing.height(24),
          SfCartesianChart(
            margin: MySpacing.zero,
            primaryXAxis: CategoryAxis(),
            tooltipBehavior: controller.chart,
            axes: <ChartAxis>[
              NumericAxis(
                  numberFormat: NumberFormat.compact(),
                  majorGridLines: const MajorGridLines(width: 0),
                  opposedPosition: true,
                  name: 'yAxis1',
                  interval: 1000,
                  minimum: 0,
                  maximum: 7000)
            ],
            series: [
              ColumnSeries<ChartSampleData, String>(
                  animationDuration: 2000,
                  width: 0.5,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                  color: contentTheme.primary,
                  dataSource: controller.chartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.y,
                  name: 'Unit Sold'),
              LineSeries<ChartSampleData, String>(
                  animationDuration: 4500,
                  animationDelay: 2000,
                  dataSource: controller.chartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.yValue,
                  yAxisName: 'yAxis1',
                  markerSettings: const MarkerSettings(isVisible: true),
                  name: 'Total Transaction')
            ],
          ),
        ],
      ),
    );
  }

  Widget worldMap() {
    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("World Map", fontWeight: 600),
          MySpacing.height(24),
          SfMaps(
            layers: [
              MapShapeLayer(
                source: controller.dataSource,
                sublayers: [
                  MapPolylineLayer(
                    polylines: List<MapPolyline>.generate(
                      controller.polylines.length,
                      (int index) {
                        return MapPolyline(
                            points: controller.polylines[index].points,
                            color: Colors.transparent,
                            onTap: () => setState(() {
                                  controller.selectedIndex = index;
                                }));
                      },
                    ).toSet(),
                  ),
                ],
                zoomPanBehavior: controller.zoomPanBehavior,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget booking() {
    return MyCard(
        shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
        paddingAll: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Bookings", fontWeight: 600),
            MySpacing.height(24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 56,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 60,
                  showBottomBorder: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                  columns: [
                    DataColumn(label: MyText.labelLarge('Id', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Name', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Check In', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Check Out', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Proof', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Payment', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Amount', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Room no', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Rooms', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                  ],
                  rows: controller.booking
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(MyText.bodySmall("#${data.id}", fontWeight: 600)),
                            DataCell(Row(
                              children: [
                                MyContainer.rounded(
                                  height: 32,
                                  width: 32,
                                  paddingAll: 0,
                                  child: Image.asset(Images.avatars[index % Images.avatars.length]),
                                ),
                                MySpacing.width(12),
                                MyText.bodySmall(data.name, fontWeight: 600),
                              ],
                            )),
                            DataCell(MyText.bodySmall(data.checkIn, fontWeight: 600)),
                            DataCell(MyText.bodySmall(data.checkOut, fontWeight: 600)),
                            DataCell(MyText.bodySmall(data.proof, fontWeight: 600)),
                            DataCell(MyText.bodySmall(data.payment, fontWeight: 600)),
                            DataCell(MyText.bodySmall(data.amount, fontWeight: 600)),
                            DataCell(
                              data.roomNo.isNotEmpty
                                  ? Wrap(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      spacing: 12,
                                      runSpacing: 12,
                                      children: data.roomNo.map((e) => MyText.bodySmall(e, fontWeight: 600)).toList(),
                                    )
                                  : SizedBox(),
                            ),
                            DataCell(MyText.bodySmall(data.rooms, fontWeight: 600)),
                            DataCell(MyText.bodySmall(data.action, fontWeight: 600)),
                          ]))
                      .toList()),
            )
          ],
        ));
  }
}
