import 'package:flutter/material.dart';
import 'story_item_stateless.dart';

class Story {
  final String username;
  bool isViewed;

  Story({
    required this.username,
    this.isViewed = false,
  });
}

/// Widget StoryBar versi Stateless
/// - State tetap dikelola oleh parent (Stateful di level bar)
/// - Item story (`StoryItemStateless`) hanya menerima data sebagai input (props)
class StoryBarStateless extends StatefulWidget {
  const StoryBarStateless({super.key});

  @override
  State<StoryBarStateless> createState() => _StoryBarStatelessState();
}

class _StoryBarStatelessState extends State<StoryBarStateless> {
  final List<Story> stories = [
    Story(username: 'user1'),
    Story(username: 'user2'),
  ];

  int _storyCounter = 3;

  void _addDummyStory() {
    setState(() {
      stories.insert(0, Story(username: 'user$_storyCounter'));
      _storyCounter++;
    });
  }

  void _toggleViewed(int index) {
    setState(() {
      stories[index].isViewed = !stories[index].isViewed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: stories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          // ====================================
          // Index 0 = "Your Story" (add button)
          // ====================================
          if (index == 0) {
            return StoryItemStateless(
              username: 'your_story',
              isViewed: false,
              isAddStory: true,
              onTap: _addDummyStory,
            );
          }

          // ====================================
          // Sisanya: user story biasa
          // ====================================
          final story = stories[index - 1];
          return StoryItemStateless(
            username: story.username,
            isViewed: story.isViewed,
            onTap: () => _toggleViewed(index - 1),
          );
        },
      ),
    );
  }
}
