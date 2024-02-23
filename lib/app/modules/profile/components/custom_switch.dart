import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mate/app/data/constants/app_color.dart';

class CustomSwitch extends StatefulWidget {
  final bool switchValue;
  final Function(bool)? switchCallback;

  const CustomSwitch({
    Key? key,
    required this.switchCallback,
    required this.switchValue,
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitchOn = false;

  @override
  void initState() {
    super.initState();
    isSwitchOn = widget.switchValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35.w,
      height: 20.h,
      child: Transform.scale(
        scale: 0.8,
        child: Theme(
          data: ThemeData(
            useMaterial3: true,
          ).copyWith(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(outline: Colors.transparent),
          ),
          child: Switch(
            activeColor: AppColors.kPrimary,
            thumbColor: const MaterialStatePropertyAll(Colors.white),
            inactiveTrackColor: const Color(0xFFEAEAEA),
            value: isSwitchOn,
            onChanged: (value) {
              setState(() {
                isSwitchOn = value;
                widget.switchCallback!(isSwitchOn);
              });
            },
          ),
        ),
      ),
    );
  }
}
