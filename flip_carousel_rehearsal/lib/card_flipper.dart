

import 'dart:math';
import 'dart:ui';

import 'package:flip_carousel_rehearsal/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flip_carousel_rehearsal/card_view.dart';

class CardFlipper extends StatefulWidget{

  final List<CardModel> cards;
  final Function onScroll;

  CardFlipper({
    this.cards,
    this.onScroll
  });


  @override
  State<StatefulWidget> createState() {
    return new _CardFlipperState();
  }

}

class _CardFlipperState extends State<CardFlipper> with TickerProviderStateMixin{

  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;


  @override
  void initState() {
    // TODO: implement initState
    finishScrollController = new AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          scrollPercent =
              lerpDouble(finishScrollStart, finishScrollEnd, finishScrollController.value);

          if (widget.onScroll != null) {
            widget.onScroll(scrollPercent);
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {});
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      child: new Stack(
        children: <Widget>[],
      ),


    );
  }


  List<Widget> _buildCards(){
    int index = -1;
    widget.cards.map((CardModel model){
      index++;
      return _buildCard(model, index, widget.cards.length, scrollPercent);

    }).toList();
  }

  Widget _buildCard(CardModel model,int cardIndex,int cardCount,double scrollPercent){

    final cardScrollPercent = scrollPercent / (1 / cardCount);
    final parallax = scrollPercent - (cardIndex / widget.cards.length);

    return new FractionalTranslation(
        translation: new Offset(cardIndex - cardScrollPercent, 0.0),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: new Transform(
              transform: _buildCardProjection(cardScrollPercent-cardIndex),
              child: CardView(cardModel: model,parallaxPercent: parallax),
            )
        )
    );

  }

  Matrix4 _buildCardProjection(double scrollPercent) {
    final perspective = 0.002;
    final radius = 1.0;
    final angle = scrollPercent * pi / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    // Model matrix by first translating the object from the origin of the world
    // by radius in the z axis and then rotating against the world.
    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    print('Angle: $angle');
    projection *= new Matrix4.translationValues(
        horizontalTranslation + (rotationPointMultiplier * 300.0), 0.0, 0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(-rotationPointMultiplier * 300.0, 0.0, 0.0);

    return projection;
  }



}


