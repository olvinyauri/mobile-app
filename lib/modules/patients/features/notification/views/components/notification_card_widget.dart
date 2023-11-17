import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/modules/patients/features/notification/models/data_notification_model.dart';
import 'package:doctor_mobile/modules/patients/features/notification/models/responses/getl_all_notification_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    super.key,
    this.isRead = false,
    this.item,
  });

  final bool isRead;
  final ItemAllNotifications? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: isRead
            ? Colors.grey.withOpacity(0.2)
            : ColorConst.primary200.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: ColorConst.primary900,
            size: 48.r,
          ),
          Container(
            width: 1,
            height: 48.h,
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            color: ColorConst.primary900,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DataNotificationModel.fromJson(item?.data ?? '').title ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConst.primary900,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  DataNotificationModel.fromJson(item?.data ?? '').message ??
                      '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorConst.primary900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  (DateTime.tryParse(item?.createdAt ?? '') ?? DateTime.now())
                      .getHumanDifferentTime(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
