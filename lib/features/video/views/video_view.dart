import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/features/home/model.dart';
import 'package:unimap/shared/providers.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends ConsumerStatefulWidget {
  final ClassModel classItem;

  const VideoScreen(
      {super.key, required this.classItem});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  late VideoPlayerController _controller;
  Timer? _timer; // Timer for updating slider

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.classItem.videoPath)
      ..initialize().then((_) {
        setState(() {}); // Update UI after initialization
        _controller.play();
        _startSliderUpdate(); // Start updating slider
      });
  }

  /// Updates slider every 500ms while video is playing
  void _startSliderUpdate() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_controller.value.isPlaying) {
        setState(() {}); // Update slider and time
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop timer when screen is disposed
    _controller.dispose();
    super.dispose();
  }

  /// Format duration to mm:ss
  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteListProvider); // Watch favorites
    bool isFavourite = favorites.any((fav) => fav.id == widget.classItem.id);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.classItem.nameEn),
        centerTitle: true,
      ),
      body: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Video Player with Full-Screen Fit
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),

                // Video Controls (Slider + Play Button)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Card(
                    color: Colors.teal.shade50.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              Slider(
                                activeColor: AppTheme.primaryColor,
                                inactiveColor: AppTheme.lightPrimary,
                                min: 0,
                                max: _controller.value.duration.inMilliseconds
                                    .toDouble(),
                                value: _controller.value.position.inMilliseconds
                                    .toDouble()
                                    .clamp(
                                        0.0,
                                        _controller
                                            .value.duration.inMilliseconds
                                            .toDouble()),
                                onChanged: (value) {
                                  _controller.seekTo(
                                      Duration(milliseconds: value.toInt()));
                                  setState(() {}); // Update UI immediately
                                },
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _formatDuration(_controller.value.position),
                                    // Current Time
                                    style:
                                        TextStyle(color: AppTheme.primaryColor),
                                  ),
                                  Spacer(),
                                  Text(
                                    _formatDuration(_controller.value.duration),
                                    // Total Duration
                                    style:
                                        TextStyle(color: AppTheme.primaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          FloatingActionButton(
                            mini: true,
                            shape: const CircleBorder(),
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.teal.shade50,
                            elevation: 0,
                            onPressed: () {
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                  _startSliderUpdate(); // Restart timer if paused
                                }
                              });
                            },
                            child: Icon(_controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        icon: Icon(
                          isFavourite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: AppTheme.primaryColor,
                        ),
                        onPressed: () {
                            ref
                                .read(favoriteListProvider.notifier)
                                .toggleFavorite(widget.classItem);
                        }),
                  ),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      // Play/Pause Button
    );
  }
}
