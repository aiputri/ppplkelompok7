// lib/views/client/home_screen.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:sikilap/controller/client/home_controller.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_flex.dart';
import 'package:sikilap/helpers/widgets/my_flex_item.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/model/hotel_model.dart';
import 'package:sikilap/model/room_model.dart';
import 'package:sikilap/views/layout/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with UIMixin {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<HomeController>(
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
                      // --- UBAH ISI ---
                      "Beranda",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(children: [
                      // --- UBAH ISI ---
                      MyBreadcrumbItem(name: 'Beranda', active: true)
                    ]),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    // --- UBAH ISI ---
                    MyFlexItem(sizes: 'lg-6', child: _buildCarouselPromo()),
                    MyFlexItem(
                      sizes: 'lg-6',
                      child: MyContainer(
                        paddingAll: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.bodyMedium(
                                // --- UBAH ISI ---
                                "Area Layanan Populer",
                                fontWeight: 600),
                            MySpacing.height(24),
                            // --- UBAH ISI ---
                            _buildAreaLayananPopuler(),
                            MySpacing.height(24),
                            MyText.bodyMedium(
                                // --- UBAH ISI ---
                                "Penawaran Spesial",
                                fontWeight: 600),
                            MySpacing.height(24),
                            // --- UBAH ISI ---
                            _buildPenawaranSpesial(),
                          ],
                        ),
                      ),
                    ),
                    // --- UBAH ISI ---
                    MyFlexItem(child: _buildMitraTerbaik()),
                    // --- UBAH ISI ---
                    MyFlexItem(child: _buildLayananUnggulan()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget ini sekarang untuk Carousel Promo
  Widget _buildCarouselPromo() {
    return CarouselSlider(
      items: controller.featuredImages.asMap().entries.map((entry) {
        int index = entry.key;
        String url = entry.value;
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: controller.hotel.isNotEmpty
                  ? () => controller.goToHotelDetail(
                      controller.hotel[index % controller.hotel.length])
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: AssetImage(url), fit: BoxFit.cover),
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
          height: 300,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          animateToClosest: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayCurve: Curves.ease),
    );
  }

  // Widget ini sekarang untuk Area Layanan Populer
  Widget _buildAreaLayananPopuler() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.destinations.length,
        itemBuilder: (context, index) {
          return MyContainer.bordered(
            height: 120,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: contentTheme.primary,
                  child:
                      Icon(LucideIcons.map_pin, size: 16, color: Colors.white),
                ),
                MyText.bodySmall(controller.destinations[index]),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => MySpacing.width(24),
      ),
    );
  }

  // Widget ini untuk Penawaran Spesial
  Widget _buildPenawaranSpesial() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.offers.length,
        itemBuilder: (context, index) {
          return MyContainer.bordered(
            padding: MySpacing.x(8),
            child: Center(child: MyText.labelMedium(controller.offers[index])),
          );
        },
        separatorBuilder: (_, __) => MySpacing.width(24),
      ),
    );
  }

  // Widget ini untuk menampilkan Mitra Terbaik
  Widget _buildMitraTerbaik() {
    return MyContainer(
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- UBAH ISI ---
          MyText.bodyMedium("Mitra Terbaik Kami", fontWeight: 600),
          MySpacing.height(24),
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: controller.hotel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                HotelModel hotel = controller.hotel[index];
                return MyContainer.bordered(
                  onTap: () => controller.goToHotelDetail(hotel),
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyContainer(
                          paddingAll: 0,
                          height: 150,
                          width: 300,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.asset(hotel.image, fit: BoxFit.cover)),
                      // --- UBAH ISI ---
                      Row(children: [
                        Icon(LucideIcons.user_cog, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium(hotel.hotelName) // Nama Mitra
                      ]),
                      Row(children: [
                        Icon(LucideIcons.user, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium(hotel.ownerName) // Nama Pemilik
                      ]),
                      Row(children: [
                        Icon(LucideIcons.mail, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium(hotel.email) // Email
                      ]),
                      Row(children: [
                        Icon(LucideIcons.map_pin, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium(hotel.cityName) // Area Layanan
                      ]),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => MySpacing.width(24),
            ),
          )
        ],
      ),
    );
  }

  // Widget ini untuk menampilkan Layanan Unggulan
  Widget _buildLayananUnggulan() {
    return MyContainer(
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- UBAH ISI ---
          MyText.bodyMedium("Layanan Unggulan", fontWeight: 600),
          MySpacing.height(24),
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: controller.allRooms.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                RoomModel room = controller.allRooms[index];
                return MyContainer.bordered(
                  onTap: () => controller.goToRoomDetail(room),
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyContainer(
                          paddingAll: 0,
                          height: 150,
                          width: 300,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.asset(room.image, fit: BoxFit.cover)),
                      // --- UBAH ISI ---
                      Row(children: [
                        Icon(LucideIcons.spray_can, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium(room.roomType) // Nama Layanan
                      ]),
                      Row(children: [
                        Icon(LucideIcons.shield_check, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium(room.bedType) // Kategori Layanan
                      ]),
                      Row(children: [
                        Icon(LucideIcons.car, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium('${room.view}') // Jenis Mobil
                      ]),
                      Row(children: [
                        Icon(LucideIcons.timer, size: 16),
                        MySpacing.width(8),
                        MyText.bodyMedium('${room.floor} Menit') // Estimasi Durasi
                      ]),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => MySpacing.width(24),
            ),
          )
        ],
      ),
    );
  }
}