// lib/views/admin/dashboard_screen.dart

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
                      "Beranda",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Beranda', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  // --- BAGIAN STATS DIUBAH ---
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Total Pesanan", "20.3K", LucideIcons.book_marked, Colors.blue)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Jumlah Mitra", "82", LucideIcons.user_cog, Colors.cyan)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Pendapatan", "Rp 150 Jt", LucideIcons.dollar_sign, Colors.teal)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Total Pelanggan", "4.5K", LucideIcons.users, Colors.indigo)),
                  MyFlexItem(sizes: 'lg-2.4', child: stats("Pesanan Selesai", "95.8%", LucideIcons.check_check, Colors.purple)),
                  // --- AKHIR PERUBAHAN STATS ---
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
              // --- JUDUL DIUBAH ---
              Expanded(child: MyText.bodyMedium("Analitik Bulanan", overflow: TextOverflow.ellipsis, fontWeight: 600)),
              PopupMenuButton(
                onSelected: controller.onSelectedTimeByLocation,
                itemBuilder: (BuildContext context) {
                  return ["Tahun", "Bulan", "Minggu", "Hari"].map((behavior) { // "Hours" dihapus
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
          Expanded( // Chart dibungkus Expanded agar fleksibel
            child: SfCartesianChart(
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
                    name: 'Jumlah Pesanan'), // Label diubah
                LineSeries<ChartSampleData, String>(
                    animationDuration: 4500,
                    animationDelay: 2000,
                    dataSource: controller.chartData,
                    xValueMapper: (ChartSampleData data, _) => data.x,
                    yValueMapper: (ChartSampleData data, _) => data.yValue,
                    yAxisName: 'yAxis1',
                    markerSettings: const MarkerSettings(isVisible: true),
                    name: 'Total Pendapatan') // Label diubah
              ],
            ),
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
          // --- JUDUL DIUBAH ---
          MyText.bodyMedium("Peta Area Layanan", fontWeight: 600),
          MySpacing.height(24),
          Expanded( // Map dibungkus Expanded agar mengisi ruang
            child: SfMaps(
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
          ),
        ],
      ),
    );
  }

  // --- BAGIAN INI DIUBAH TOTAL ---
  Widget booking() {
    return MyCard(
        shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
        paddingAll: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Pesanan Terbaru", fontWeight: 600),
            MySpacing.height(24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 48,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 60,
                  showBottomBorder: false, // Dibuat false agar lebih bersih
                  columns: [
                    DataColumn(label: MyText.labelLarge('ID Pesanan', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Pelanggan', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Jadwal Layanan', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Layanan', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Total Biaya', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Status', color: contentTheme.primary)),
                  ],
                  rows: controller.booking // Asumsi controller.booking sudah disesuaikan
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(MyText.bodySmall(data.id as String, fontWeight: 600)), // Menggunakan ID pesanan (misal: "SKL-001")
                            DataCell(Row(
                              children: [
                                MyContainer.rounded(
                                  height: 32,
                                  width: 32,
                                  paddingAll: 0,
                                  child: Image.asset(Images.avatars[index % Images.avatars.length]),
                                ),
                                MySpacing.width(12),
                                MyText.bodySmall(data.namaPelanggan, fontWeight: 600), // Ganti ke nama pelanggan
                              ],
                            )),
                            DataCell(MyText.bodySmall(data.jadwalLayanan, fontWeight: 600)), // Ganti ke jadwal
                            DataCell(MyText.bodySmall(data.jenisLayanan, fontWeight: 600)), // Ganti ke jenis layanan
                            DataCell(MyText.bodySmall("Rp ${NumberFormat.decimalPattern('id').format(data.totalBiaya)}", fontWeight: 600)), // Ganti ke total biaya
                            DataCell(
                              MyContainer.bordered(
                                padding: MySpacing.xy(8, 4),
                                color: data.statusPesanan == "Selesai" ? contentTheme.success.withAlpha(40) : contentTheme.warning.withAlpha(40),
                                border: Border.all(color: data.statusPesanan == "Selesai" ? contentTheme.success : contentTheme.warning),
                                child: MyText.labelSmall(data.statusPesanan, fontWeight: 600, color: data.statusPesanan == "Selesai" ? contentTheme.success : contentTheme.warning),
                              ),
                            ),
                          ]))
                      .toList()),
            )
          ],
        ));
  }
}