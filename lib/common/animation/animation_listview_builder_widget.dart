import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationListViewBuilderWidget<T> extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final double? verticalOffset;
  final double? horizontalOffset;
  final Axis listScrollDirection;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index)
  itemBuilder;


  const AnimationListViewBuilderWidget(
      {Key? key,
      this.duration = const Duration(milliseconds: 225),
      this.horizontalOffset = 0.0,
      required this.itemBuilder,
      required this.items,
      this.curve = Curves.ease,
      this.listScrollDirection = Axis.vertical,
      this.verticalOffset = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: duration,
            child: SlideAnimation(
              verticalOffset: verticalOffset,
              horizontalOffset: horizontalOffset,
              child: FadeInAnimation(
                curve: curve,
                child: itemBuilder(context, items[index], index),
              ),
            ),
          );
        },
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: listScrollDirection,
      ),
    );
  }
}
