import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stay_place/controller/client/my_booking_controller.dart';
import 'package:stay_place/helpers/utils/my_shadow.dart';
import 'package:stay_place/helpers/utils/ui_mixins.dart';
import 'package:stay_place/helpers/widgets/my_breadcrumb.dart';
import 'package:stay_place/helpers/widgets/my_breadcrumb_item.dart';
import 'package:stay_place/helpers/widgets/my_card.dart';
import 'package:stay_place/helpers/widgets/my_list_extension.dart';
import 'package:stay_place/helpers/widgets/my_spacing.dart';
import 'package:stay_place/helpers/widgets/my_text.dart';
import 'package:stay_place/helpers/widgets/responsive.dart';
import 'package:stay_place/views/layout/layout.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> with UIMixin {
  MyBookingController controller = Get.put(MyBookingController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'my_booking_controller',
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
                      "My Booking",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'My Booking', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard(
                  shadow: MyShadow(
                      elevation: 0.2, position: MyShadowPosition.bottom),
                  paddingAll: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium("My Bookings", fontWeight: 600),
                      MySpacing.height(24),
                      if (controller.myBooking.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              sortAscending: true,
                              onSelectAll: (_) => {},
                              dataRowMaxHeight: 60,
                              columnSpacing: 25,
                              showBottomBorder: false,
                              showCheckboxColumn: true,
                              border: TableBorder.all(
                                  style: BorderStyle.solid,
                                  width: .4,
                                  color: Colors.grey),
                              columns: [
                                DataColumn(
                                    label: MyText.bodySmall('Booking ID',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Guest Name',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Hotel Name',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Room Type',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Check In Date',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Check Out Date',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Booking Date',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Number Of Guests',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Total Price',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Currency',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Payment Method',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Special Requests',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodySmall('Booking Status',
                                        fontWeight: 600)),
                              ],
                              rows: controller.myBooking
                                  .mapIndexed((index, data) => DataRow(
                                        cells: [
                                          DataCell(MyText.labelSmall(
                                              data.bookingID)),
                                          DataCell(MyText.labelSmall(
                                              data.guestName)),
                                          DataCell(MyText.labelSmall(
                                              data.hotelName)),
                                          DataCell(
                                              MyText.labelSmall(data.roomType)),
                                          DataCell(MyText.labelSmall(
                                              data.checkInDate)),
                                          DataCell(MyText.labelSmall(
                                              data.checkOutDate)),
                                          DataCell(MyText.labelSmall(
                                              data.bookingDate)),
                                          DataCell(MyText.labelSmall(
                                              data.numberOfGuest.toString())),
                                          DataCell(MyText.labelSmall(
                                              '\$${data.totalPrice}')),
                                          DataCell(
                                              MyText.labelSmall(data.currency)),
                                          DataCell(MyText.labelSmall(
                                              data.paymentMethod)),
                                          DataCell(MyText.labelSmall(
                                              data.specialRequests)),
                                          DataCell(MyText.labelSmall(
                                              data.bookingStatus)),
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
