import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/admin/manage_booking/booking_list_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/images.dart';
import 'package:sikilap/views/layout/layout.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> with UIMixin {
  BookingListController controller = Get.put(BookingListController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'admin_booking_list_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Booking List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Booking List', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 260,
                  ),
                  itemCount: controller.booking.length,
                  itemBuilder: (context, index) {
                    final booking = controller.booking[index];
                    return MyCard(
                      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                      paddingAll: 24,
                      onTap: controller.roomDetail,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyContainer.rounded(
                                paddingAll: 0,
                                height: 40,
                                width: 40,
                                child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                              ),
                              MySpacing.width(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.bodyMedium(booking.guestName, fontWeight: 600, maxLines: 1, overflow: TextOverflow.ellipsis),
                                    MyText.bodySmall(booking.guestEmail, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              MyContainer(
                                padding: MySpacing.xy(8, 4),
                                color: contentTheme.primary,
                                child: MyText.labelSmall(
                                  booking.roomType,
                                  fontWeight: 600,
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          MyText.labelMedium("Phone Number : ${booking.guestPhoneNumber}"),
                          MyText.labelMedium("Room Number : ${booking.roomNumber}"),
                          MyText.labelMedium("Hotel Name : ${booking.hotelName}"),
                          MyText.labelMedium("Price : \$${booking.totalPrice}"),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
