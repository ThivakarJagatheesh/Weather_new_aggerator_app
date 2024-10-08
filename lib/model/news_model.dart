// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
    final List<Article>? articles;

    News({
        this.articles,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        articles: json["articles"] == null ? [] : List<Article>.from(json["articles"]!.map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "articles": articles == null ? [] : List<dynamic>.from(articles!.map((x) => x.toJson())),
    };
}

class Article {
    final Source? source;
    final String? author;
    final String? title;
    final dynamic description;
    final String? url;
    final dynamic urlToImage;
    final DateTime? publishedAt;
    final dynamic content;

    Article({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"]??"",
        title: json["title"]??"",
        description: json["description"]??"",
        url: json["url"]??"",
        urlToImage: json["urlToImage"]??"",
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"]??"",
    );

    Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
    };
}

class Source {
    final Id? id;
    final Name? name;

    Source({
        this.id,
        this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]]??Id.GOOGLE_NEWS,
        name: nameValues.map[json["name"]]??Name.GOOGLE_NEWS,
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
    };
}

enum Id {
    GOOGLE_NEWS
}

final idValues = EnumValues({
    "google-news": Id.GOOGLE_NEWS
});

enum Name {
    GOOGLE_NEWS
}

final nameValues = EnumValues({
    "Google News": Name.GOOGLE_NEWS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
