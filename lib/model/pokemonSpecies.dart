// To parse this JSON data, do
//
//     final pokemonSpecies = pokemonSpeciesFromJson(jsonString);

import 'dart:convert';

PokemonSpecies pokemonSpeciesFromJson(String str) => PokemonSpecies.fromJson(json.decode(str));

String pokemonSpeciesToJson(PokemonSpecies data) => json.encode(data.toJson());

class PokemonSpecies {
    int baseHappiness;
    int captureRate;
    NameLinkModel color;
    List<NameLinkModel> eggGroups;
    EvolutionChain evolutionChain;
    dynamic evolvesFromSpecies;
    List<FlavorTextEntry> flavorTextEntries;
    List<dynamic> formDescriptions;
    bool formsSwitchable;
    int genderRate;
    List<Genus> genera;
    NameLinkModel generation;
    NameLinkModel growthRate;
    NameLinkModel habitat;
    bool hasGenderDifferences;
    int hatchCounter;
    int id;
    bool isBaby;
    String name;
    List<Name> names;
    int order;
    List<PalParkEncounter> palParkEncounters;
    List<PokedexNumber> pokedexNumbers;
    NameLinkModel shape;
    List<Variety> varieties;

    PokemonSpecies({
        this.baseHappiness,
        this.captureRate,
        this.color,
        this.eggGroups,
        this.evolutionChain,
        this.evolvesFromSpecies,
        this.flavorTextEntries,
        this.formDescriptions,
        this.formsSwitchable,
        this.genderRate,
        this.genera,
        this.generation,
        this.growthRate,
        this.habitat,
        this.hasGenderDifferences,
        this.hatchCounter,
        this.id,
        this.isBaby,
        this.name,
        this.names,
        this.order,
        this.palParkEncounters,
        this.pokedexNumbers,
        this.shape,
        this.varieties,
    });

    factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
        baseHappiness: json["base_happiness"],
        captureRate: json["capture_rate"],
        color: NameLinkModel.fromJson(json["color"]),
        eggGroups: List<NameLinkModel>.from(json["egg_groups"].map((x) => NameLinkModel.fromJson(x))),
        evolutionChain: EvolutionChain.fromJson(json["evolution_chain"]),
        evolvesFromSpecies: json["evolves_from_species"],
        flavorTextEntries: List<FlavorTextEntry>.from(json["flavor_text_entries"].map((x) => FlavorTextEntry.fromJson(x))),
        formDescriptions: List<dynamic>.from(json["form_descriptions"].map((x) => x)),
        formsSwitchable: json["forms_switchable"],
        genderRate: json["gender_rate"],
        genera: List<Genus>.from(json["genera"].map((x) => Genus.fromJson(x))),
        generation: NameLinkModel.fromJson(json["generation"]),
        growthRate: NameLinkModel.fromJson(json["growth_rate"]),
        habitat: NameLinkModel.fromJson(json["habitat"]),
        hasGenderDifferences: json["has_gender_differences"],
        hatchCounter: json["hatch_counter"],
        id: json["id"],
        isBaby: json["is_baby"],
        name: json["name"],
        names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        order: json["order"],
        palParkEncounters: List<PalParkEncounter>.from(json["pal_park_encounters"].map((x) => PalParkEncounter.fromJson(x))),
        pokedexNumbers: List<PokedexNumber>.from(json["pokedex_numbers"].map((x) => PokedexNumber.fromJson(x))),
        shape: NameLinkModel.fromJson(json["shape"]),
        varieties: List<Variety>.from(json["varieties"].map((x) => Variety.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "base_happiness": baseHappiness,
        "capture_rate": captureRate,
        "color": color.toJson(),
        "egg_groups": List<dynamic>.from(eggGroups.map((x) => x.toJson())),
        "evolution_chain": evolutionChain.toJson(),
        "evolves_from_species": evolvesFromSpecies,
        "flavor_text_entries": List<dynamic>.from(flavorTextEntries.map((x) => x.toJson())),
        "form_descriptions": List<dynamic>.from(formDescriptions.map((x) => x)),
        "forms_switchable": formsSwitchable,
        "gender_rate": genderRate,
        "genera": List<dynamic>.from(genera.map((x) => x.toJson())),
        "generation": generation.toJson(),
        "growth_rate": growthRate.toJson(),
        "habitat": habitat.toJson(),
        "has_gender_differences": hasGenderDifferences,
        "hatch_counter": hatchCounter,
        "id": id,
        "is_baby": isBaby,
        "name": name,
        "names": List<dynamic>.from(names.map((x) => x.toJson())),
        "order": order,
        "pal_park_encounters": List<dynamic>.from(palParkEncounters.map((x) => x.toJson())),
        "pokedex_numbers": List<dynamic>.from(pokedexNumbers.map((x) => x.toJson())),
        "shape": shape.toJson(),
        "varieties": List<dynamic>.from(varieties.map((x) => x.toJson())),
    };
}

class NameLinkModel {
    String name;
    String url;

    NameLinkModel({
        this.name,
        this.url,
    });

    factory NameLinkModel.fromJson(Map<String, dynamic> json) => NameLinkModel(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

class EvolutionChain {
    String url;

    EvolutionChain({
        this.url,
    });

    factory EvolutionChain.fromJson(Map<String, dynamic> json) => EvolutionChain(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}

class FlavorTextEntry {
    String flavorText;
    NameLinkModel language;
    NameLinkModel version;

    FlavorTextEntry({
        this.flavorText,
        this.language,
        this.version,
    });

    factory FlavorTextEntry.fromJson(Map<String, dynamic> json) => FlavorTextEntry(
        flavorText: json["flavor_text"],
        language: NameLinkModel.fromJson(json["language"]),
        version: NameLinkModel.fromJson(json["version"]),
    );

    Map<String, dynamic> toJson() => {
        "flavor_text": flavorText,
        "language": language.toJson(),
        "version": version.toJson(),
    };
}

class Genus {
    String genus;
    NameLinkModel language;

    Genus({
        this.genus,
        this.language,
    });

    factory Genus.fromJson(Map<String, dynamic> json) => Genus(
        genus: json["genus"],
        language: NameLinkModel.fromJson(json["language"]),
    );

    Map<String, dynamic> toJson() => {
        "genus": genus,
        "language": language.toJson(),
    };
}

class Name {
    NameLinkModel language;
    String name;

    Name({
        this.language,
        this.name,
    });

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        language: NameLinkModel.fromJson(json["language"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "language": language.toJson(),
        "name": name,
    };
}

class PalParkEncounter {
    NameLinkModel area;
    int baseScore;
    int rate;

    PalParkEncounter({
        this.area,
        this.baseScore,
        this.rate,
    });

    factory PalParkEncounter.fromJson(Map<String, dynamic> json) => PalParkEncounter(
        area: NameLinkModel.fromJson(json["area"]),
        baseScore: json["base_score"],
        rate: json["rate"],
    );

    Map<String, dynamic> toJson() => {
        "area": area.toJson(),
        "base_score": baseScore,
        "rate": rate,
    };
}

class PokedexNumber {
    int entryNumber;
    NameLinkModel pokedex;

    PokedexNumber({
        this.entryNumber,
        this.pokedex,
    });

    factory PokedexNumber.fromJson(Map<String, dynamic> json) => PokedexNumber(
        entryNumber: json["entry_number"],
        pokedex: NameLinkModel.fromJson(json["pokedex"]),
    );

    Map<String, dynamic> toJson() => {
        "entry_number": entryNumber,
        "pokedex": pokedex.toJson(),
    };
}

class Variety {
    bool isDefault;
    NameLinkModel pokemon;

    Variety({
        this.isDefault,
        this.pokemon,
    });

    factory Variety.fromJson(Map<String, dynamic> json) => Variety(
        isDefault: json["is_default"],
        pokemon: NameLinkModel.fromJson(json["pokemon"]),
    );

    Map<String, dynamic> toJson() => {
        "is_default": isDefault,
        "pokemon": pokemon.toJson(),
    };
}
