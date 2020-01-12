// To parse this JSON data, do
//
//     final movesResponse = movesResponseFromJson(jsonString);

import 'dart:convert';

MovesResponse movesResponseFromJson(String str) => MovesResponse.fromJson(json.decode(str));

String movesResponseToJson(MovesResponse data) => json.encode(data.toJson());

class MovesResponse {
    int count;
    String next;
    String previous;
    List<Result> results;

    MovesResponse({
        this.count,
        this.next,
        this.previous,
        this.results,
    });

    factory MovesResponse.fromJson(Map<String, dynamic> json) => MovesResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String name;
    String url;

    Result({
        this.name,
        this.url,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
