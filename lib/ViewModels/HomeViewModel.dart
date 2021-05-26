import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Adapters/ApiServices/MusicPlayerApiService.dart';
import 'package:music_player/Models/Models.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class HomeViewModel extends GetxController {
  MusicPlayerApiService apiService = Get.find();
  TextEditingController searchController = TextEditingController();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('song_player');

  RxList<Result> songList = <Result>[].obs;
  RxBool isPlaying = false.obs;
  RxBool isError = false.obs;
  Rx<Duration> currentPosition = Duration().obs;
  Rx<Duration> duration = Duration().obs;

  int nowPlayingIndex;
  Timer _debounce;

  @override
  void onInit() {
    super.onInit();
    searchSong(keyword: "maroon 5");
  }

  @override
  void onClose() {
    super.onClose();
    _debounce?.cancel();
  }

  void searchSong({String keyword}) async {
    if (_debounce?.isActive ?? false) _debounce.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        var response = await apiService.searchSong(keyword: keyword);

        if (response.hasError) {
          print(response.bodyString);
          return;
        }
        songList.value = response.body.results;
      } catch (error) {
        isError.value = true;
      }
    });
  }

  void selectSong(int index) async {
    nowPlayingIndex = index;

    songList.forEach((element) {
      element.isSelected = false;
    });
    songList[index].isSelected = true;

    try {
      await assetsAudioPlayer.open(
        Audio.network(songList[index].previewUrl),
        autoStart: true,
      );
      isPlaying.value = true;
    } catch (t) {
      //mp3 unreachable
    }
    songList.refresh();
  }

  void playOrPause() {
    assetsAudioPlayer.playOrPause();
    isPlaying.toggle();
  }

  void onPrevious() {
    if (nowPlayingIndex - 1 >= 0) {
      nowPlayingIndex -= 1;
      selectSong(nowPlayingIndex);
    }
  }

  void onNext() {
    if (nowPlayingIndex + 1 < songList.length) {
      nowPlayingIndex += 1;
      selectSong(nowPlayingIndex);
    }
  }

  void changePlayerSeek(double newValue) {
    final seekDuration = Duration(seconds: newValue.floor());
    assetsAudioPlayer.seek(seekDuration);
  }

  void initDuration({Duration currentPosition, Duration duration}) {
    this.currentPosition.value = currentPosition;
    this.duration.value = duration;

    if (this.currentPosition.value.inSeconds >= this.duration.value.inSeconds) {
      onNext();
    }
  }
}
