// To parse this JSON data, do
//
//     final welcome = pokemonListResponseFromJson(jsonString);

import 'dart:convert';

List<PokemonListModel> pokemonListResponseFromJson(String str) {
     return List<PokemonListModel>.from(json.decode(str).map((x) => PokemonListModel.fromJson(x)));
     
    // String welcomeToJson(List<PokemonListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  }

String pokemonListResponse(List<PokemonListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PokemonListModel {
    String id;
    int orderId;
    int nDex;
    String name;
    String type1;
    String type2;
    String ability1;
    String ability2;
    String hiddenability;
    int hp;
    int atk;
    int def;
    int spatk;
    int spdef;
    int spe;
    String note;
    String tier;
    String image;

    PokemonListModel({
        this.id,
        this.orderId,
        this.nDex,
        this.name,
        this.type1,
        this.type2,
        this.ability1,
        this.ability2,
        this.hiddenability,
        this.hp,
        this.atk,
        this.def,
        this.spatk,
        this.spdef,
        this.spe,
        this.note,
        this.tier,
        this.image,
    });

    factory PokemonListModel.fromJson(Map<String, dynamic> json) => PokemonListModel(
        id: json["id"],
        orderId: json["orderID"],
        nDex: json["nDex"],
        name: json["name"],
        type1: json["type1"],
        type2: json["type2"],
        ability1: json["ability1"],
        ability2: json["ability2"],
        hiddenability: json["hiddenability"],
        hp: json["hp"],
        atk: json["atk"],
        def: json["def"],
        spatk: json["spatk"],
        spdef: json["spdef"],
        spe: json["spe"],
        note: json["note"],
        tier: json["tier"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderID": orderId,
        "nDex": nDex,
        "name": name,
        "type1": type1,
        "type2": type2,
        "ability1": ability1,
        "ability2": ability2,
        "hiddenability": hiddenability,
        "hp": hp,
        "atk": atk,
        "def": def,
        "spatk": spatk,
        "spdef": spdef,
        "spe": spe,
        "note": note,
        "tier": tier,
        "image": image,
    };
}
