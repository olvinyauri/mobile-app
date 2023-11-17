enum PaymentTypeEnum { transfer, bpjs }

extension PaymentTypeEnumExtension on PaymentTypeEnum {
  String get name {
    switch (this) {
      case PaymentTypeEnum.transfer:
        return 'Transfer';
      case PaymentTypeEnum.bpjs:
        return 'BPJS';
      default:
        return '';
    }
  }
}
