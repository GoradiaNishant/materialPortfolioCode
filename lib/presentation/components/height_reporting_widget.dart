import 'package:flutter/material.dart';

class HeightReportingWidget extends StatefulWidget {
  final Widget child;
  final void Function(double height) onHeightChanged;

  const HeightReportingWidget({
    Key? key,
    required this.child,
    required this.onHeightChanged,
  }) : super(key: key);

  @override
  State<HeightReportingWidget> createState() => _HeightReportingWidgetState();
}

class _HeightReportingWidgetState extends State<HeightReportingWidget> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reportSize());
  }

  void _reportSize() {
    final ctx = _key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box != null) {
      widget.onHeightChanged(box.size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: _key, child: widget.child);
  }
}
