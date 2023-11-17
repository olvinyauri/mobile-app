import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputTextWidget extends StatelessWidget {
  const CustomInputTextWidget({
    super.key,
    this.readOnly = false,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    required this.title,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.onTap,
    this.controller,
    this.keyboardType,
  });

  final bool readOnly;
  final EdgeInsetsGeometry margin;
  final String title;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int maxLines;
  final Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: ColorConst.primary900,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: ColorConst.primary900,
            ),
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.w,
              ),
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: ColorConst.primary500,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: ColorConst.primary500,
                ),
              ),
              suffixIcon: suffixIcon != null
                  ? Icon(
                      suffixIcon!,
                      color: ColorConst.primary500,
                    )
                  : null,
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon!,
                      color: ColorConst.primary500,
                    )
                  : null,
            ),
            readOnly: readOnly,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
