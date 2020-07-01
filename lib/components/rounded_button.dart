import 'package:flutter/material.dart';
import 'package:weights/size_config.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressAction;

  RoundedButton({
    this.title,
    this.backgroundColor,
    this.textColor,
    @required this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
      child: Material(
        shadowColor: Colors.white30,
        elevation: 7.0,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 4),
        child: MaterialButton(
          onPressed: onPressAction,
          minWidth: SizeConfig.blockSizeHorizontal * 60,
          height: SizeConfig.blockSizeVertical * 7,
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: SizeConfig.blockSizeVertical * 2.4,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class PlainButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final Function onPressAction;

  PlainButton({
    this.title,
    this.textColor,
    @required this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 70,
      height: SizeConfig.blockSizeVertical * 8,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 4),
          side: BorderSide(color: Colors.white.withOpacity(0.5), width: 2.5),
        ),
        color: Colors.transparent,
        textColor: textColor,
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
        onPressed: onPressAction,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.blockSizeVertical * 2,
            color: Colors.black87,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
