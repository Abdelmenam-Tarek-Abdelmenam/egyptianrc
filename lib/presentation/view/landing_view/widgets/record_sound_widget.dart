import 'dart:io';

import 'package:audioplayers/audioplayers.dart' as audio_player;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:egyptianrc/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordSoundWidget extends StatefulWidget {
  const RecordSoundWidget({Key? key}) : super(key: key);

  @override
  State<RecordSoundWidget> createState() => _RecordSoundWidgetState();
}

class _RecordSoundWidgetState extends State<RecordSoundWidget> {
  final recorder = FlutterSoundRecorder();
  bool recorderIsReady = false;
  File? audioFile;

  @override
  void initState() {
    initRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return recorderIsReady
        ? Row(
            children: [
              AvatarGlow(
                glowColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                endRadius: 38.0,
                animate: recorder.isRecording,
                child: CircleAvatar(
                  radius: 24,
                  child: IconButton(
                      iconSize: 30,
                      onPressed: () async {
                        if (recorder.isRecording) {
                          final path = await recorder.stopRecorder();
                          audioFile = File(path!);
                        } else {
                          audioFile = null;
                          await recorder.startRecorder(toFile: 'audio');
                        }
                        setState(() {});
                      },
                      icon: Icon(recorder.isRecording
                          ? Icons.mic_off_outlined
                          : Icons.mic_none)),
                ),
              ),
              Expanded(child: SoundPlayerWidget(audioFile?.path)),
            ],
          )
        : const LinearProgressIndicator();
  }

  Future<void> initRecord() async {
    final state = await Permission.microphone.request();
    if (state != PermissionStatus.granted) {
      throw 'Microphone permission denied';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));

    setState(() {
      recorderIsReady = true;
    });
  }

  String formatTime(Duration duration) =>
      "${duration.inSeconds}:${duration.inMilliseconds.remainder(1000) ~/ 10}";
}

class SoundPlayerWidget extends StatefulWidget {
  SoundPlayerWidget(String? url, {bool isUrl = false, super.key})
      : source = url == null
            ? null
            : isUrl
                ? audio_player.UrlSource(url)
                : audio_player.DeviceFileSource(url);

  final audio_player.Source? source;

  @override
  State<SoundPlayerWidget> createState() => _SoundPlayerWidgetState();
}

class _SoundPlayerWidgetState extends State<SoundPlayerWidget> {
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final audio_player.AudioPlayer player = audio_player.AudioPlayer();

  @override
  void didUpdateWidget(_) {
    if (widget.source != null) {
      player.seek(Duration.zero);
      player.pause();
      position = Duration.zero;
      player.getDuration().then((value) => duration = value ?? Duration.zero);
      player.release();
      player.setSource(widget.source!);
    }
    super.didUpdateWidget(_);
  }

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5).copyWith(left: 15),
      decoration: BoxDecoration(
          boxShadow: StyleManager.smallShadow,
          color: Theme.of(context).colorScheme.background,
          borderRadius: StyleManager.border,
          border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    if (widget.source == null) return;
                    if (isPlaying) {
                      await player.pause();
                    } else {
                      await player.play(widget.source!);
                    }
                    setState(() {});
                  },
                  child: Icon(
                    isPlaying ? Icons.stop : Icons.play_arrow,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noThumb,
                  ),
                  child: Slider(
                    min: 0,
                    max: duration.inMilliseconds.toDouble(),
                    value: position.inMilliseconds.toDouble(),
                    onChanged: (val) async {
                      await player.seek(Duration(milliseconds: val.toInt()));
                      await player.resume();
                    },
                  ),
                ),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("duration ${formatTime(duration)}"),
          //     Text(formatTime(position)),
          //   ],
          // ),
        ],
      ),
    );
  }

  String formatTime(Duration duration) =>
      "${duration.inSeconds}:${duration.inMilliseconds.remainder(1000) ~/ 10}";

  void initPlayer() {
    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == audio_player.PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    player.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }
}
