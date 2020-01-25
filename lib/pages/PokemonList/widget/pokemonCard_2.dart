import 'package:flutter/material.dart';

import '../../../helper/colorTheme.dart';
import '../../../model/pokemonList.dart';
import '../../../widgets/customWidget.dart';

class PokemonCard2 extends StatelessWidget {
  const PokemonCard2({Key key, this.model, this.onPressed, this.onLongPressed})
      : super(key: key);

  final PokemonListModel model;
  final Function onLongPressed;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      onLongPress: onLongPressed,
      child: Container(
        decoration: BoxDecoration(
            color: setprimaryColor(model.type1),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: <Widget>[
            Positioned(
                bottom: 0,
                right: 0,
                height: getDimention(context, 110),
                child: Image.asset(
                  'assets/images/pokeball.png',
                  color: setSecondaryColor('#' + model.type1),
                )),
            Positioned(
                bottom: 10,
                right: 10,
                child: Hero(
                  tag: model.orderId,
                  child: Image(
                    image: customAdvanceNetworkImage(
                      model.image,
                    ),
                    fit: BoxFit.contain,
                    height: getDimention(context, 100),
                  ),
                ))
          ],
        )
      ),
    );
  }
}
