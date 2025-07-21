import 'package:flutter/material.dart';
import 'package:flutter_instagram_feed/presentation/widgets/story_stateful/story_item_stateful.dart';

/// model story
class Story {
  final String username;
  bool isViewed;

  Story({
    required this.username,
    this.isViewed = false,
  });
}

class StoryBarStateful extends StatefulWidget {
  const StoryBarStateful({super.key});

  @override
  State<StoryBarStateful> createState() => _StoryBarStatefulState();
}

/// StoryBar versi Stateful
/// - Mengelola daftar story dan status `isViewed`
/// - Dapat menambahkan dummy story dengan tombol "+"

class _StoryBarStatefulState extends State<StoryBarStateful> {
  // List dummy story
  final List<Story> stories = [
    Story(username: 'user1'),
    Story(username: 'user2'),
    Story(username: 'user3'),
  ];

  int _storyCounter = 3;

  /// Menambahkan story baru ke awal list (dummy data)
  void _addDummyStory() {
    setState(() {
      stories.insert(
        0,
        Story(username: 'user$_storyCounter'),
      );
      _storyCounter++;
    });
  }

  /// Mengubah status story: sudah dilihat ↔ belum dilihat
  void _toggleViewed(int index) {
    setState(() {
      stories[index].isViewed = !stories[index].isViewed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          // ===============================
          // Index 0 adalah "Your Story"
          // ===============================
          if (index == 0) {
            return StoryItemStateful(
              username: 'your_story',
              isAddStory: true,
              onTap: _addDummyStory,
            );
          }
          // ===============================
          // Sisanya: story dari user lain
          // ===============================
          final story = stories[index - 1];

          return StoryItemStateful(
            username: story.username,
            isAddStory: false,
            onTap: () => _toggleViewed(index - 1),
          );
        },
      ),
    );
  }
}
