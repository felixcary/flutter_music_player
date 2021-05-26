import 'dart:convert';

import 'package:get/get.dart';
import 'package:music_player/Models/Models.dart';

class MusicPlayerApiService extends GetConnect {
  @override
  onInit() {
    httpClient.baseUrl = "https://itunes.apple.com";
    httpClient.addRequestModifier((request) {
      request.headers['Accept'] = 'application/json; charset=UTF-8';
      return request;
    });
  }

  Future<Response<SearchResultModel>> searchSong({String keyword}) {
    var url = '/search?entity=song&term=$keyword';

    return get(
      url,
      decoder: (json) {
        var decoded = jsonDecode(json);
        return SearchResultModel.fromJson(decoded);
      },
    );
  }
}
