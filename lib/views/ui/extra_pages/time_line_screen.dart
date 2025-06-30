import 'package:sikilap/controller/ui/extra_pages/time_line_controller.dart';
import 'package:sikilap/helpers/utils/my_shadow.dart';
import 'package:sikilap/helpers/utils/ui_mixins.dart';
import 'package:sikilap/helpers/utils/utils.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb.dart';
import 'package:sikilap/helpers/widgets/my_breadcrumb_item.dart';
import 'package:sikilap/helpers/widgets/my_card.dart';
import 'package:sikilap/helpers/widgets/my_container.dart';
import 'package:sikilap/helpers/widgets/my_spacing.dart';
import 'package:sikilap/helpers/widgets/my_text.dart';
import 'package:sikilap/helpers/widgets/responsive.dart';
import 'package:sikilap/images.dart';
import 'package:flutter/material.dart';
import 'package:sikilap/model/drag_n_drop.dart';
import 'package:sikilap/views/layout/layout.dart';
import 'package:get/get.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({super.key});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> with SingleTickerProviderStateMixin, UIMixin {
  late TimeLineController controller;

  @override
  void initState() {
    controller = TimeLineController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'time_line_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Time Line", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [MyBreadcrumbItem(name: 'Extra'), MyBreadcrumbItem(name: 'Time Line', active: true)],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: Column(
                  children: [
                    SizedBox(
                      height: 800,
                      child: Timeline.tileBuilder(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shrinkWrap: true,
                        builder: TimelineTileBuilder.fromStyle(
                          indicatorStyle: IndicatorStyle.outlined,
                          itemCount: controller.timeline.length,
                          contentsAlign: ContentsAlign.alternating,
                          connectorStyle: ConnectorStyle.dashedLine,
                          contentsBuilder: (context, index) {
                            DragNDropModel time = controller.timeline[index];
                            return MyCard(
                              shadow: MyShadow(elevation: 0.2, position: MyShadowPosition.bottom),
                              width: 400,
                              margin: MySpacing.x(24),
                              paddingAll: 24,
                              child: Column(
                                crossAxisAlignment: index % 2 == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                children: [
                                  MyText.bodyMedium(time.contactName, fontWeight: 600, overflow: TextOverflow.ellipsis),
                                  MySpacing.height(12),
                                  MyContainer(
                                    paddingAll: 0,
                                    height: 100,
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.asset(Images.dummy[index % Images.dummy.length], fit: BoxFit.cover),
                                  ),
                                  MySpacing.height(12),
                                  MyText.bodyMedium(
                                    Utils.getDateTimeStringFromDateTime(time.createdAt),
                                    fontWeight: 600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  MySpacing.height(12),
                                  MyText.bodySmall(
                                    "Location : ${time.location}",
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(12),
                                  MyText.bodyMedium(
                                    controller.dummyTexts[index],
                                    fontWeight: 600,
                                    maxLines: 3,
                                    textAlign: index % 2 == 0 ? TextAlign.start : TextAlign.end,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
