
import 'package:flip_carousel_rehearsal/card_model.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget{

  final CardModel cardModel;
  final double parallaxPercent;

  CardView({
    this.cardModel,
    this.parallaxPercent = 0.0
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: new Container(
            child: new Image.asset(cardModel.backdropAssetPath,fit: BoxFit.cover,)
          )
        )
        
        
      ],
    );
  }


}