import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sikilap/controller/admin/manage_hotels/hotel_detail_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_button.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_flex.dart';
import 'package:sikilap/helpers/widgets/my_flex_item.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_star_rating.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/model/room_model.dart';
import 'package:sikilap/views/layout/layout.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> with UIMixin {
  HotelDetailController controller = Get.put(HotelDetailController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'hotel_detail_controller',
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
                      "Hotel Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Hotel Detail', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(child: reviews()),
                    MyFlexItem(child: details()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget reviews() {
    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Zenith Hotel", fontWeight: 600),
          MySpacing.height(8),
          MyStarRating(rating: 5, activeColor: contentTheme.warning),
          MySpacing.height(8),
          MyText.labelMedium("Kompl Kav Polri Bl A-19/434, Dki Jakarta"),
          MySpacing.height(16),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: controller.hotelImage
                .map((e) => MyContainer(paddingAll: 0, height: 200, width: 200, child: Image.asset(e.toString(), fit: BoxFit.cover)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget details() {
    List<Widget> tabWidgets = [room(), about(), facility(), location()];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: controller.tabTitles.asMap().entries.map((entry) {
            int index = entry.key;
            String title = entry.value;
            return customTab(index, title);
          }).toList(),
        ),
        MySpacing.height(24),
        tabWidgets[controller.isSelectedTab],
      ],
    );
  }

  Widget customTab(int id, String title) {
    bool isSelected = controller.isSelectedTab == id;
    return MyContainer(
      onTap: () => controller.onSelectTab(id),
      paddingAll: 12,
      color: isSelected ? contentTheme.primary : null,
      child: MyText.labelMedium(title, color: isSelected ? contentTheme.onPrimary : null),
    );
  }

  Widget room() {
    Widget roomSection(String title, List roomSectionList) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelLarge(title),
          MySpacing.height(12),
          ...roomSectionList.map((e) => Padding(
                padding: MySpacing.bottom(4),
                child: Row(
                  children: [
                    Icon(LucideIcons.check, size: 12),
                    MySpacing.width(12),
                    Expanded(child: MyText.labelMedium(e, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              )),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: controller.room.length,
        itemBuilder: (context, index) {
          RoomModel room = controller.room[index];
          return MyContainer.bordered(
            paddingAll: 24,
            child: MyFlex(
                contentPadding: false,
                wrapAlignment: WrapAlignment.start,
                wrapCrossAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: [
                  MyFlexItem(
                      sizes: 'lg-2 md-2',
                      child: MyContainer(
                        paddingAll: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(room.image, fit: BoxFit.cover),
                      )),
                  MyFlexItem(
                      sizes: 'lg-10 md-10',
                      child: Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(room.roomType, fontWeight: 600, color: contentTheme.primary),
                                  MySpacing.height(8),
                                  Row(
                                    children: [
                                      Icon(LucideIcons.bed_single, size: 16),
                                      MySpacing.width(12),
                                      MyText.labelMedium(room.bedType),
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  MyFlex(children: [
                                    MyFlexItem(sizes: 'lg-4 md-6', child: roomSection("Amenities", room.amenities)),
                                    MyFlexItem(sizes: 'lg-4 md-6', child: roomSection("Guest Service", room.guestService)),
                                    MyFlexItem(sizes: 'lg-4 md-6', child: roomSection("Inclusion", room.inclusion)),
                                  ]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  MyText.titleLarge("\$${room.pricePerNight}", fontWeight: 600),
                                  MyText.bodySmall("per night"),
                                  MyButton(
                                      onPressed: () {},
                                      backgroundColor: contentTheme.primary,
                                      elevation: 0,
                                      child: MyText.labelMedium("Book Now", fontWeight: 600, color: contentTheme.onPrimary)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ]),
          );
        },
        separatorBuilder: (context, index) {
          return MySpacing.height(24);
        },
      ),
    );
  }

  Widget about() {
    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelLarge("Enjoy a luxurious experience!", fontWeight: 600),
          MySpacing.height(12),
          MyText.bodySmall(controller.dummyTexts[0]),
          MySpacing.height(12),
          MyText.labelLarge("Hotel Facilities", fontWeight: 600),
          MySpacing.height(12),
          MyText.bodySmall(controller.dummyTexts[1]),
          MySpacing.height(12),
          MyText.labelLarge("Dining", fontWeight: 600),
          MySpacing.height(12),
          MyText.bodySmall(controller.dummyTexts[2]),
          MySpacing.height(12),
          MyText.labelLarge("Room Facilities", fontWeight: 600),
          MySpacing.height(12),
          MyText.bodySmall(controller.dummyTexts[3]),
        ],
      ),
    );
  }

  Widget facility() {
    Widget title(IconData icon, String title) {
      return Row(
        children: [
          Icon(icon),
          MySpacing.width(12),
          MyText.labelLarge(title),
        ],
      );
    }

    Widget section(String titleText, IconData iconData, List items) {
      return Column(
        children: [
          title(iconData, titleText),
          MySpacing.height(24),
          ...items.map((e) => Padding(
                padding: MySpacing.bottom(4),
                child: Row(
                  children: [Icon(LucideIcons.check, size: 12), MySpacing.width(12), MyText.labelMedium(e)],
                ),
              )),
        ],
      );
    }

    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: MyFlex(
        contentPadding: false,
        children: [
          MyFlexItem(
            sizes: 'lg-2.4',
            child: section("Basic Facility", LucideIcons.circle_check, controller.basicFacility),
          ),
          MyFlexItem(
            sizes: 'lg-2.4',
            child: section("Payment Mode", LucideIcons.wallet_cards, controller.paymentMode),
          ),
          MyFlexItem(
            sizes: 'lg-2.4',
            child: section("Security", LucideIcons.cctv, controller.security),
          ),
          MyFlexItem(
            sizes: 'lg-2.4',
            child: section("Food & Drinks", LucideIcons.hand_platter, controller.foodAndDrinks),
          ),
          MyFlexItem(
            sizes: 'lg-2.4',
            child: section("Activities", LucideIcons.dumbbell, controller.activities),
          ),
        ],
      ),
    );
  }

  Widget location() {
    return MyCard(
      shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: SizedBox(
        height: 600,
        child: GoogleMap(
          onMapCreated: controller.onMapCreated,
          initialCameraPosition: CameraPosition(target: controller.center, zoom: 11.0),
        ),
      ),
    );
  }

  Widget customerReviews() {
    return MyContainer(
      child: MyText("Customer Reviews"),
    );
  }
}
