import 'package:flutter/material.dart';
import '../../../helper/colorTheme.dart';
import '../../../model/pokemonList.dart';
import '../../../widgets/customWidget.dart';

class PokemonCard3 extends StatelessWidget {
  const PokemonCard3({Key key, this.model, this.onPressed, this.onLongPressed})
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
        height: 40,
        decoration: BoxDecoration(
            color: setprimaryColor(model.type1),
            borderRadius: BorderRadius.circular(10)),
        child: Hero(
          tag: model.orderId,
          child: Image(
            image: customAdvanceNetworkImage(
              model.image,
            ),
            fit: BoxFit.contain,
            height: getDimention(context, 30),
          ),
        ),
      )
    );
  }
}
