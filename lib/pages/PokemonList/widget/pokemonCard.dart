import 'package:flutter/material.dart';
import '../../../helper/colorTheme.dart';
import '../../../model/pokemonList.dart';
import '../../../widgets/customWidget.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({Key key, this.model, this.onPressed, this.onLongPressed})
      : super(key: key);

  final PokemonListModel model;
  final Function onLongPressed;
  final Function onPressed;

  Widget _pokemonTypeWidget(BuildContext context, String type, Color color) {
    if (type == null || type.isEmpty) {
      return SizedBox();
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Text(
          type,
          style: TextStyle(
              color: Colors.white60,
              fontSize: getFontSize(context, 10),
              fontWeight: FontWeight.w600),
        ),
      );
    }
  }

  String getId(String id) {
    return '#' +
        (id.toString().length == 1
            ? '00' + id.toString()
            : id.toString().length == 2 ? '0' + id.toString() : id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      onLongPress: onLongPressed,
      child: Container(
          margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: setprimaryColor(model.type1),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: <Widget>[
              ///[Pokemon ID]
              Positioned(
                bottom: getDimention(context, 10),
                left: getDimention(context, 10),
                child: customText(getId(model.orderId.toString()),
                    style: TextStyle(
                        color: setSecondaryColor(model.type1),
                        fontSize: getFontSize(context, 12),
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ),

              ///[Pokeball]
              Positioned(
                  bottom: 0,
                  right: 0,
                  height: getDimention(context, 80),
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: setSecondaryColor('#' + model.type1),
                    height: getDimention(context, 150),
                  )),

              /// [Name, Type]
              Positioned(
                  top: getDimention(context, 20),
                  left: getDimention(context, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: fullWidth(context) * .3,
                        child: customText(model.name,
                            context: context,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getFontSize(context, 14),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start),
                      ),
                      _pokemonTypeWidget(
                          context, model.type1, setSecondaryColor(model.type1)),
                      SizedBox(
                        height: 5,
                      ),
                      _pokemonTypeWidget(
                          context, model.type2, setSecondaryColor(model.type1)),
                    ],
                  )),

              /// [Image]
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
                      height: getDimention(context, 70),
                    ),
                  )
              )
            ],
          )
      ),
    );
  }
}
