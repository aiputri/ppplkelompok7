import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/client/payment_history_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/utils/utils.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_list_extension.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> with UIMixin {
  PaymentHistoryController controller = Get.put(PaymentHistoryController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'payment_history_controller',
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
                      "Payment History",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Payment History', active: true),
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
                      MyText.bodyMedium("Payment History", fontWeight: 600),
                      MySpacing.height(24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            dataRowMaxHeight: 60,
                            columnSpacing: 55,
                            showBottomBorder: false,
                            showCheckboxColumn: true,
                            border: TableBorder.all(style: BorderStyle.solid, width: .4, color: Colors.grey),
                            columns: [
                              DataColumn(label: MyText.bodySmall('Transaction ID', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Booking ID', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Payment ID', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Guest Name', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Amount Paid', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Currency', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Payment Method', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Payment Date', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Payment Note', fontWeight: 600)),
                              DataColumn(label: MyText.bodySmall('Status', fontWeight: 600)),
                            ],
                            rows: controller.paymentHistory
                                .mapIndexed((index, data) => DataRow(
                                      cells: [
                                        DataCell(MyText.labelSmall(data.transactionID)),
                                        DataCell(MyText.labelSmall(data.bookingID)),
                                        DataCell(MyText.labelSmall(data.paymentID)),
                                        DataCell(MyText.labelSmall(data.guestName)),
                                        DataCell(MyText.labelSmall("\$${data.amountPaid}")),
                                        DataCell(MyText.labelSmall(data.currency)),
                                        DataCell(MyText.labelSmall(data.paymentMethod)),
                                        DataCell(
                                            MyText.labelSmall(Utils.getDateTimeStringFromDateTime(data.paymentDate, showMonthShort: true, showSecond: false))),
                                        DataCell(SizedBox(width: 250, child: MyText.labelSmall(data.paymentNote))),
                                        DataCell(MyText.labelSmall(data.paymentStatus)),
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
