import 'package:flutter/material.dart';
import 'package:smart_code_mentor/components/constants.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final double width;

  const RoundButton({
    required this.text,
    required this.onClick,
    required this.width, 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Center(
          child: InkWell(
            onTap: onClick,
            child: Container(
              height: 60,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryColor,
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
