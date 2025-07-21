import 'package:flutter/material.dart';

class StoryItemStateless extends StatelessWidget {
  final String username;
  final bool isViewed;
  final bool isAddStory;
  final VoidCallback? onTap;

  const StoryItemStateless({
    super.key,
    required this.username,
    this.isViewed = false,
    this.isAddStory = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isAddStory ? Colors.grey : (isViewed ? Colors.grey : Colors.redAccent);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              // Outer border
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),

              if (isAddStory)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 64,
            child: Text(
              isAddStory ? "Your Story" : username,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
