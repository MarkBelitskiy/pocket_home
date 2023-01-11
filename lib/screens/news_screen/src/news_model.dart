import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    required this.newsTitle,
    required this.newsText,
    required this.filePath,
    required this.publishDate,
    required this.pollAnswers,
    required this.choosenPollValue,
  });

  String newsTitle;
  String newsText;
  String filePath;
  DateTime publishDate;
  List<String>? pollAnswers;
  int? choosenPollValue;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        newsTitle: json["newsTitle"],
        newsText: json["newsText"],
        filePath: json["filePath"] ?? '',
        choosenPollValue: json["choosenPollValue"],
        publishDate: DateTime.parse(json["publishDate"]),
        pollAnswers: json["pollAnswers"] == null
            ? null
            : List<String>.from(json["pollAnswers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "newsTitle": newsTitle,
        "newsText": newsText,
        "filePath": filePath,
        "choosenPollValue": choosenPollValue,
        "publishDate": publishDate.toIso8601String(),
        "pollAnswers": pollAnswers == null
            ? null
            : List<dynamic>.from(pollAnswers!.map((x) => x)),
      };
}
