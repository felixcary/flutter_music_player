import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:music_player/Adapters/ApiServices/MusicPlayerApiService.dart';

void main() {
  var apiService = Get.put(MusicPlayerApiService());

  group('Music Api Service', () {
    test('result should not be empty', () async {
      var res = await apiService.searchSong(keyword: "maroon 5");
      expect(res.body.resultCount, 50);
    });
  });
}
