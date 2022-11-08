import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/common/colors.dart';

class BottomNavigationItem extends StatelessWidget {
  final String iconSvg;
  final String title;
  final Function() onPressed;
  final bool isSelected;

  const BottomNavigationItem(
      {Key? key,
      required this.iconSvg,
      required this.title,
      required this.onPressed,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: InkWell(
        onTap: onPressed,
        highlightColor: Color(
            isSelected ? MovieColor.colorHighlight : MovieColor.colorText),
        child: Stack(
          children: [
            Visibility(
              visible: isSelected,
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                    color: Color(MovieColor.colorPrimary),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      iconSvg,
                      color: Color(isSelected
                          ? MovieColor.colorPrimary
                          : MovieColor.colorText),
                    ),
                    const SizedBox(width: 10),
                    Text(title,
                        style: TextStyle(
                            color: Color(isSelected
                                ? MovieColor.colorPrimary
                                : MovieColor.colorText),
                            fontSize: 12,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
