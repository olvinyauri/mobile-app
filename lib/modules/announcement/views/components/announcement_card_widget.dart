import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/modules/announcement/models/responses/get_all_announcements_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnnouncementCardWidget extends StatelessWidget {
  const AnnouncementCardWidget({
    super.key,
    this.item,
  });

  final ItemAnnouncement? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => item?.image != null,
            widgetBuilder: (BuildContext context) => ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                item?.image ?? "",
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100.w,
                  height: 100.w,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorConst.analogous100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            fallbackBuilder: (BuildContext context) => Container(
              width: 100.w,
              height: 100.w,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorConst.analogous100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(
                Icons.image,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.title ?? "",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      (DateTime.tryParse(item?.createdAt ?? "") ??
                              DateTime.now())
                          .extToFormattedString(
                              outputDateFormat: 'EEEE, dd MMMM yyyy HH:mm'),
                      style: TextStyle(
                        fontSize: 8.sp,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      item?.content ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Baca Selengkapnya",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConst.primary500,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: ColorConst.primary500,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
