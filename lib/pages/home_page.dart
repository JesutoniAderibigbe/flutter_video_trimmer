import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_edit_player/pages/video_edited_page.dart';

import 'package:video_edit_player/pages/video_trimmer_page.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String? editedVideoPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //video trimmer
      appBar: AppBar(
        title: Text("Video Trimmer"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
            child: Text("LOAD VIDEO"),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.video,
                allowCompression: false,
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                final editedPath = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return TrimmerView(file);
                  }),
                );

                setState(() {
                  editedVideoPath = editedPath;
                });
              }
            },
          ),
        ),
      ),

      floatingActionButton: editedVideoPath != null
          ? FloatingActionButton(
              onPressed: () {
                // Display the edited video using a video player or any other widget
                // Replace 'YourVideoPlayerWidget' with your video player widget
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return VideoEditedPage(editedVideoPath!);
                  }),
                );
              },
              child: Icon(Icons.play_arrow),
            )
          : null,
    );
  }
}
