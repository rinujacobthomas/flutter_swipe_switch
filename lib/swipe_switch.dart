library swipe_switch;

import 'package:flutter/material.dart';

class SwipeSwitch extends StatefulWidget {
  /// a switch with high customization
  /// use inside a parent widget with proper height and width
  /// [value] is whether its  on or off.
  final bool value;

  ///[onChanged] callback return a bool.
  final ValueChanged<bool> onChanged;
  final Color activeFillColor;
  final Color inactiveFillColor;
  final Color activeSwichColor;
  final Color inactiveSwitchColor;

  ///[showText] whether to show on or off text
  final bool showText;
  final String activeText;
  final String inactiveText;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final BoxShadow switchShadow;
  final EdgeInsetsGeometry switchPadding;
  final double switchSize;

  const SwipeSwitch({
    Key key,
    this.value,
    this.onChanged,
    this.activeFillColor = Colors.blue,
    this.inactiveFillColor = Colors.grey,
    this.activeSwichColor = Colors.white,
    this.inactiveSwitchColor = Colors.white,
    this.showText = true,
    this.activeText = 'On',
    this.inactiveText = 'Off',
    this.activeTextStyle = const TextStyle(
        color: Colors.green, fontWeight: FontWeight.w900, fontSize: 16.0),
    this.inactiveTextStyle = const TextStyle(
        color: Colors.red, fontWeight: FontWeight.w900, fontSize: 16.0),
    this.activeBorderColor = Colors.black,
    this.inactiveBorderColor = Colors.black,
    this.switchPadding =
        const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
    this.switchShadow = const BoxShadow(color: Colors.white, spreadRadius: 2),
    this.switchSize = 15.5,
  }) : super(key: key);

  @override
  _SwipeSwitchState createState() => _SwipeSwitchState();
}

class _SwipeSwitchState extends State<SwipeSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _switchAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 70));
    _switchAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
            onTap: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              widget.value ? widget.onChanged(false) : widget.onChanged(true);
            },
            child: Container(
              padding: widget.switchPadding,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  border: Border.all(
                      color: _switchAnimation.value == Alignment.centerLeft
                          ? widget.inactiveBorderColor
                          : widget.activeBorderColor),
                  color: _switchAnimation.value == Alignment.centerLeft
                      ? widget.inactiveFillColor
                      : widget.activeFillColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _switchAnimation.value == Alignment.centerRight
                      ? Text(widget.activeText, style: widget.activeTextStyle)
                      : Container(),
                  Align(
                    alignment: _switchAnimation.value,
                    child: Container(
                      width: widget.switchSize,
                      height: widget.switchSize,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  _switchAnimation.value == Alignment.centerLeft
                      ? Text(
                          widget.inactiveText,
                          style: widget.inactiveTextStyle,
                        )
                      : Container(),
                ],
              ),
            ));
      },
    );
  }
}
