import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/widget/custom_input_text_widget.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/components/upload_file_widget.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/controllers/4_choose_payment_method_controller.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/enum/payment_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChoosePaymentMethod extends StatelessWidget {
  const ChoosePaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChoosePaymentMethodController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputTextWidget(
              controller: controller.paymentMethodTextController,
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.w,
              ),
              readOnly: true,
              onTap: () {
                controller.showPaymentChooser(context);
              },
              title: "Metode Pembayaran",
              hintText: "Pilih Metode Pembayaran",
              prefixIcon: Icons.payment,
              suffixIcon: Icons.arrow_drop_down,
            ),
            Obx(
              () => Conditional.single(
                context: context,
                conditionBuilder: (_) =>
                    controller.paymentType.value == PaymentTypeEnum.transfer,
                widgetBuilder: (_) => Column(
                  children: [
                    UploadFileWidget(
                      controller: controller.paymentProofTextController,
                      hintText: 'Upload Bukti Pembayaran',
                      title: 'Bukti Pembayaran',
                      onTap: () {
                        controller.selectImage('paymentProof');
                      },
                    ),
                  ],
                ),
                fallbackBuilder: (_) => Column(
                  children: [
                    UploadFileWidget(
                      controller: controller.ktpTextController,
                      hintText: 'Upload KTP',
                      title: 'KTP',
                      onTap: () {
                        controller.selectImage('ktp');
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    UploadFileWidget(
                      controller: controller.bpjsTextController,
                      hintText: 'Upload Kartu BPJS',
                      title: 'Kartu BPJS',
                      onTap: () {
                        controller.selectImage('bpjs');
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    UploadFileWidget(
                      controller: controller.referringLetterTextController,
                      hintText: 'Upload Surat Rujukan',
                      title: 'Surat Rujukan',
                      onTap: () {
                        controller.selectImage('suratRujukan');
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 48.h,
            ),
            GestureDetector(
              onTap: () {
                controller.bookDoctor();
              },
              child: Container(
                width: 1.sw,
                height: 48,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: ColorConst.primary500,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: const Center(
                  child: Text(
                    'Lanjutkan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
