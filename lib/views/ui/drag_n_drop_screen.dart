import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:sikilap/controller/ui/drag_n_drop_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/views/layout/layout.dart';
import 'package:get/get.dart';

class DragNDropScreen extends StatefulWidget {
  const DragNDropScreen({super.key});

  @override
  State<DragNDropScreen> createState() => _DragNDropScreenState();
}

class _DragNDropScreenState extends State<DragNDropScreen> with SingleTickerProviderStateMixin, UIMixin {
  late DragNDropController controller;

  @override
  void initState() {
    controller = Get.put(DragNDropController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'drag_n_drop_controller',
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
                      "Drag & Drop",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Widgets'),
                        MyBreadcrumbItem(name: 'Drag & Drop', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              if (controller.contact.isNotEmpty)
                Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: SizedBox(
                    height: 700,
                    child: ReorderableGridView.extent(
                      maxCrossAxisExtent: 250,
                      onReorder: controller.onReorder,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.95,
                      children: controller.contact.map((item) {
                        return MyCard(
                          shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                          key: ValueKey(item),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyContainer(
                                paddingAll: 0,
                                child: Image.asset(item.image),
                              ),
                              Text(item.contactName),
                            ],
                          ),
                        );
                      }).toList(),
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
