import 'package:blood/fitness_app_theme.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;

  const TitleView({
    super.key,
    this.titleTxt = "",
    this.subTxt = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              titleTxt,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
                color: FitnessAppTheme.lightText,
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    subTxt,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: FitnessAppTheme.fontName,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: FitnessAppTheme.nearlyDarkBlue,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
