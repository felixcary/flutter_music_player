import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/Models/Models.dart';
import 'package:music_player/Utils/ViewUtils.dart';
import 'package:music_player/ViewModels/ViewModels.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return GetX<HomeViewModel>(
      init: viewModel,
      builder: (viewModel) => Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Scaffold(
            appBar: _searchAppBar(),
            body: _songPlaylist(),
            bottomNavigationBar: _musicControl(),
          ),
        ),
      ),
    );
  }

  AppBar _searchAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: TextField(
          controller: viewModel.searchController,
          cursorColor: Colors.black87,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                viewModel.searchController.clear();
              },
              child: Icon(
                Icons.clear,
                color: Colors.black87,
              ),
            ),
            hintText: 'Search...',
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              viewModel.searchSong(keyword: value);
            }
          },
        ),
      ),
    );
  }

  Widget _songPlaylist() {
    if (viewModel.songList.isEmpty) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Looking for something to listen?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text("Search your favorite song"),
            ],
          ),
        ),
      );
    }
    if (viewModel.isError.value) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 36,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Please check your internet connection",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: viewModel.songList.length,
        itemBuilder: (context, index) {
          return _songContainer(index: index);
        },
      ),
    );
  }

  Widget _songContainer({int index}) {
    final Result song = viewModel.songList[index];

    return GestureDetector(
      onTap: () {
        viewModel.selectSong(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                song.artworkUrl100,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.trackName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      song.artistName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      song.collectionName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (song.isSelected)
              Container(
                height: 100,
                width: 60,
                child: Image.asset(
                  "assets/gifs/audioSpectrum.gif",
                  fit: BoxFit.fitWidth,
                ),
              )
            else
              Container()
          ],
        ),
      ),
    );
  }

  Widget _musicControl() {
    if (!viewModel.isPlaying.value) {
      return null;
    }
    return viewModel.assetsAudioPlayer.builderRealtimePlayingInfos(
      builder: (context, RealtimePlayingInfos infos) {
        viewModel.initDuration(
          currentPosition: infos.currentPosition,
          duration: infos.duration,
        );
        return Container(
          height: 90,
          color: Colors.white,
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      size: 36,
                    ),
                    onPressed: () {
                      viewModel.onPrevious();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      viewModel.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 36,
                    ),
                    onPressed: () {
                      viewModel.playOrPause();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 36,
                    ),
                    onPressed: () {
                      viewModel.onNext();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    child: Text(
                      ViewUtils().intToString(
                          viewModel.currentPosition.value.inSeconds),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.red,
                          inactiveTrackColor: Colors.red[200],
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 4,
                          thumbColor: Colors.red,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 8),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 0),
                        ),
                        child: Slider(
                          min: 0,
                          max: viewModel.duration.value.inSeconds.toDouble() +
                              1.0,
                          value: viewModel.currentPosition.value.inSeconds
                              .toDouble(),
                          onChanged: (value) {
                            viewModel.changePlayerSeek(value);
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: Text(
                      ViewUtils()
                          .intToString(viewModel.duration.value.inSeconds),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
