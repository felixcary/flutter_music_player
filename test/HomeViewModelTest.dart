import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:music_player/Adapters/ApiServices/MusicPlayerApiService.dart';
import 'package:music_player/Models/Models.dart';
import 'package:music_player/ViewModels/ViewModels.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final binding = BindingsBuilder(() {
    Get.lazyPut<MusicPlayerApiService>(() => MusicPlayerApiService());
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
  });

  List<Result> songList = [
    Result(
      trackId: 1,
      trackName: "Track 1",
      artistName: "Artis 1",
      collectionName: "Album 1",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview71/v4/41/88/26/418826e9-af89-b4ed-54c1-4954e8b9675c/mzaf_9102060361208754189.plus.aac.p.m4a",
      isSelected: false,
    ),
    Result(
      trackId: 2,
      trackName: "Track 2",
      artistName: "Artis 2",
      collectionName: "Album 2",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview71/v4/41/88/26/418826e9-af89-b4ed-54c1-4954e8b9675c/mzaf_9102060361208754189.plus.aac.p.m4a",
      isSelected: false,
    ),
    Result(
      trackId: 3,
      trackName: "Track 3",
      artistName: "Artis 3",
      collectionName: "Album 3",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview71/v4/41/88/26/418826e9-af89-b4ed-54c1-4954e8b9675c/mzaf_9102060361208754189.plus.aac.p.m4a",
      isSelected: false,
    ),
  ];

  group('Home view model', () {
    binding.builder();
    final viewModel = Get.find<HomeViewModel>();
    test('song list should not be empty', () async {
      expect(viewModel.initialized, true);
      viewModel.songList.value = songList;

      expect(viewModel.songList.length, 3);
    });

    test('artis name should be artis 2', () async {
      viewModel.songList.value = songList;
      viewModel.selectSong(1);
      viewModel.assetsAudioPlayer.stop();

      expect(
          viewModel.songList[viewModel.nowPlayingIndex].artistName, "Artis 2");
    });

    test('artis name should be artis 1', () async {
      viewModel.songList.value = songList;
      viewModel.selectSong(1);
      viewModel.onPrevious();
      viewModel.assetsAudioPlayer.stop();

      expect(
          viewModel.songList[viewModel.nowPlayingIndex].artistName, "Artis 1");
    });

    test('artis name should be artis 3', () async {
      viewModel.songList.value = songList;
      viewModel.selectSong(1);
      viewModel.onNext();
      viewModel.assetsAudioPlayer.stop();

      expect(
          viewModel.songList[viewModel.nowPlayingIndex].artistName, "Artis 3");
    });
  });
}
