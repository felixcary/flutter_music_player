class SearchResultModel {
  SearchResultModel({
    this.resultCount,
    this.results,
  });

  int resultCount;
  List<Result> results;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        resultCount: json["resultCount"] == null ? null : json["resultCount"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCount": resultCount == null ? null : resultCount,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.previewUrl,
    this.artworkUrl100,
    this.isSelected = false,
  });

  int trackId;
  String artistName;
  String collectionName;
  String trackName;
  String previewUrl;
  String artworkUrl100;
  bool isSelected;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        trackId: json["trackId"] == null ? null : json["trackId"],
        artistName: json["artistName"] == null ? null : json["artistName"],
        collectionName:
            json["collectionName"] == null ? null : json["collectionName"],
        trackName: json["trackName"] == null ? null : json["trackName"],
        previewUrl: json["previewUrl"] == null ? null : json["previewUrl"],
        artworkUrl100:
            json["artworkUrl100"] == null ? null : json["artworkUrl100"],
      );

  Map<String, dynamic> toJson() => {
        "trackId": trackId == null ? null : trackId,
        "artistName": artistName == null ? null : artistName,
        "collectionName": collectionName == null ? null : collectionName,
        "trackName": trackName == null ? null : trackName,
        "previewUrl": previewUrl == null ? null : previewUrl,
        "artworkUrl100": artworkUrl100 == null ? null : artworkUrl100,
      };
}
