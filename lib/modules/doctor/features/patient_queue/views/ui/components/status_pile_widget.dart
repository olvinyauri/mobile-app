import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusPileWidget extends StatefulWidget {
  const StatusPileWidget({
    super.key,
    this.status,
    this.width,
  });

  final int? status;
  final double? width;

  @override
  State<StatusPileWidget> createState() => _StatusPileWidgetState();
}

class _StatusPileWidgetState extends State<StatusPileWidget> {
  _StatusPileData? _statusPileData;

  @override
  void initState() {
    super.initState();
    _setStatusPileData();
  }

  void _setStatusPileData() {
    switch (widget.status) {
      case 0:
        _statusPileData = _StatusPileData(
          text: 'Menunggu',
          color: Colors.grey.withOpacity(0.2),
          textColor: Colors.black,
        );
        break;
      case 1:
        _statusPileData = _StatusPileData(
          text: 'Dalam Proses',
          color: Colors.blueAccent.withOpacity(0.2),
          textColor: Colors.blue,
        );
        break;
      case 2:
        _statusPileData = _StatusPileData(
          text: 'Selesai',
          color: Colors.greenAccent.withOpacity(0.2),
          textColor: Colors.green,
        );
        break;

      case 3:
        _statusPileData = _StatusPileData(
          text: 'Ditolak',
          color: Colors.redAccent.withOpacity(0.2),
          textColor: Colors.red,
        );
        break;
      default:
        _statusPileData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _statusPileData?.color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        _statusPileData?.text ?? '-',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: _statusPileData?.textColor,
        ),
      ),
    );
  }
}

class _StatusPileData {
  final String text;
  final Color color;
  final Color textColor;

  _StatusPileData({
    required this.text,
    required this.color,
    required this.textColor,
  });
}
