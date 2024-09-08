import 'package:flutter/material.dart';
import '../../core/router/routing.dart';
import '../../core/utils/extensions.dart';

class BottomSheetTemplateWidget extends StatelessWidget {
  const BottomSheetTemplateWidget({
    super.key,
    required this.title,
    required this.widget,
  });
  final String title;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.style.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // const Spacer(),
              IconButton(
                  onPressed: () {
                    RouteManager.pop();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          Expanded(
            child: widget,
          )
        ],
      ),
    );
  }
}
