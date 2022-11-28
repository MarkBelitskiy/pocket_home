import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    required this.newsTitle,
    required this.newsText,
    required this.filePath,
    required this.publishDate,
    required this.pollAnswers,
  });

  String newsTitle;
  String newsText;
  String filePath;
  DateTime publishDate;
  List<String>? pollAnswers;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        newsTitle: json["newsTitle"],
        newsText: json["newsText"],
        filePath: json["filePath"] ?? '',
        publishDate: DateTime.parse(json["publishDate"]),
        pollAnswers: json["pollAnswers"] == null
            ? null
            : List<String>.from(json["pollAnswers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "newsTitle": newsTitle,
        "newsText": newsText,
        "filePath": filePath,
        "publishDate": publishDate.toIso8601String(),
        "pollAnswers": pollAnswers == null
            ? null
            : List<dynamic>.from(pollAnswers!.map((x) => x)),
      };
}
