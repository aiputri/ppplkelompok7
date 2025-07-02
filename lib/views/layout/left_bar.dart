// lib/views/layout/left_bar.dart

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sikilap/helpers/services/url_service.dart';
import 'package:sikilap/helpers/theme/theme_customizer.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_router.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/images.dart';
import 'package:sikilap/widgets/custom_pop_menu.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;
  final bool isAdmin;

  const LeftBar({super.key, this.isCondensed = false, required this.isAdmin});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;
  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return AnimatedContainer(
      color: leftBarTheme.background,
      width: isCondensed ? 70 : 270,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: InkWell(
              onTap: () =>
                  Get.toNamed(widget.isAdmin ? '/admin/dashboard' : '/home'),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      ThemeCustomizer.instance.theme == ThemeMode.light
                          ? Images.logoLight
                          : Images.logoDark,
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain),
                ],
              ),
            ),
          ),
          MySpacing.height(8),
          Expanded(
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================== LOGIKA UTAMA (ADMIN & CLIENT MENU) ===================
                    if (widget.isAdmin) ...[
                      // --- MENU ADMIN (TIDAK DIUBAH) ---
                      LabelWidget(
                          isCondensed: isCondensed, label: "ADMIN PANEL"),
                      NavigationItem(
                          iconData: LucideIcons.layout_dashboard,
                          title: "Beranda",
                          isCondensed: isCondensed,
                          route: '/admin/dashboard'),
                      MenuWidget(
                        iconData: LucideIcons.user_cog,
                        isCondensed: isCondensed,
                        title: "Manage Mitra",
                        children: [
                          MenuItem(
                              title: "List Mitra",
                              isCondensed: isCondensed,
                              route: '/admin/hotel/list'),
                          MenuItem(
                              title: "Tambah Mitra",
                              isCondensed: isCondensed,
                              route: '/admin/hotel/add'),
                        ],
                      ),
                      MenuWidget(
                        iconData: LucideIcons.spray_can,
                        isCondensed: isCondensed,
                        title: "Manage Layanan",
                        children: [
                          MenuItem(
                              title: "List Layanan",
                              isCondensed: isCondensed,
                              route: '/admin/room/list'),
                          MenuItem(
                              title: "Tambah Layanan",
                              isCondensed: isCondensed,
                              route: '/admin/room/add'),
                        ],
                      ),
                      MenuWidget(
                        iconData: LucideIcons.users,
                        isCondensed: isCondensed,
                        title: "Manage Pelanggan",
                        children: [
                          MenuItem(
                              title: "List Pelanggan",
                              isCondensed: isCondensed,
                              route: '/admin/guest/list'),
                        ],
                      ),
                      NavigationItem(
                          iconData: LucideIcons.book_marked,
                          title: "Manage Pesanan",
                          isCondensed: isCondensed,
                          route: '/admin/booking/list'),
                      NavigationItem(
                          iconData: LucideIcons.credit_card,
                          title: "Payment History",
                          isCondensed: isCondensed,
                          route: '/admin/payment'),
                    ] else ...[
                      // --- MENU CLIENT (UBAH ISI DI SINI) ---
                      LabelWidget(
                          isCondensed: isCondensed, label: "MENU PENGGUNA"),
                      NavigationItem(
                          iconData: LucideIcons.bomb,
                          title: "Beranda", // Home -> Beranda
                          isCondensed: isCondensed,
                          route: '/home'),
                      NavigationItem(
                          iconData: LucideIcons.spray_can, // Ikon lebih relevan
                          title: "Pilih Layanan", // Room Selection -> Pilih Layanan
                          isCondensed: isCondensed,
                          route: '/room_selection'),
                      NavigationItem(
                          iconData: LucideIcons.shopping_cart, // Ikon lebih relevan
                          title: "Pemesanan", // Booking Form -> Pemesanan
                          isCondensed: isCondensed,
                          route: '/booking_form'),
                      NavigationItem(
                          iconData: LucideIcons.history, // Ikon lebih relevan
                          title: "Pesanan Saya", // My Bookings -> Pesanan Saya
                          isCondensed: isCondensed,
                          route: '/my_booking'),
                      NavigationItem(
                          iconData: LucideIcons.wallet, // Ikon lebih relevan
                          title: "Pembayaran", // Payment History -> Pembayaran
                          isCondensed: isCondensed,
                          route: '/payment_history'),
                      NavigationItem(
                          iconData: LucideIcons.map, // Ikon lebih relevan
                          title: "Lokasi", // Location Map -> Lokasi
                          isCondensed: isCondensed,
                          route: '/location_map'),
                    ],
                    // =======================================================================
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? MySpacing.empty()
        : Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(label.toUpperCase(),
                color: leftBarTheme.labelColor,
                muted: true,
                maxLines: 1,
                overflow: TextOverflow.clip,
                fontWeight: 700),
          );
  }
}

// =========================================================================
// SISA KODE DI BAWAH INI TIDAK DIUBAH, CUKUP SALIN DAN TEMPEL SEPERTI ASLINYA
// =========================================================================

class LabelWidget extends StatelessWidget {
  final bool isCondensed;
  final String label;

  const LabelWidget(
      {super.key, required this.isCondensed, required this.label});

  @override
  Widget build(BuildContext context) {
    if (isCondensed) {
      return SizedBox();
    }
    return Container(
        margin: MySpacing.fromLTRB(16, 0, 16, 8),
        child: MyText.labelSmall(label, xMuted: true, fontWeight: 700));
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;

  const MenuWidget(
      {super.key,
      required this.iconData,
      required this.title,
      this.isCondensed = false,
      this.active = false,
      this.children = const []});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (hide) => hideFn = hide,
        onChange: (value) {
          popupShowing = value;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive)
                    ? leftBarTheme.activeItemColor
                    : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer(
          paddingAll: 8,
          borderRadiusAll: 8,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            child: ExpansionTile(
                tilePadding: MySpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (value) {
                  LeftbarObserver.notifyAll(widget.title);
                  onChangeExpansion(value);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    LucideIcons.chevron_down,
                    size: 18,
                    color: leftBarTheme.onBackground,
                  ),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: MySpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.iconData,
                      size: 20,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                    MySpacing.width(18),
                    Expanded(
                      child: MyText.labelLarge(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        color: isHover || isActive
                            ? leftBarTheme.activeItemColor
                            : leftBarTheme.onBackground,
                      ),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.transparent,
                children: widget.children),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    LeftbarObserver.detachListener(widget.title);
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: MySpacing.xy(18, 7),
          child: MyText.bodySmall(
            "${widget.isCondensed ? "-" : "- "}  ${widget.title}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontSize: 12.5,
            color: isActive || isHover
                ? leftBarTheme.activeItemColor
                : leftBarTheme.onBackground,
            fontWeight: isActive || isHover ? 600 : 500,
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem(
      {super.key,
      this.iconData,
      required this.title,
      this.isCondensed = false,
      this.route});

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
          MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer(
          margin: MySpacing.fromLTRB(16, 0, 16, 8),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          padding: MySpacing.xy(8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(
                    widget.iconData,
                    color: (isHover || isActive)
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                    size: 20,
                  ),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: MySpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}