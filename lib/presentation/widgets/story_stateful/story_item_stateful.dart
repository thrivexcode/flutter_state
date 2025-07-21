import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// Widget Story Item versi Stateful
/// - Menangani status: dilihat/belum, dan loading saat menambah story
/// - Menampilkan avatar, status border, dan tombol "+"
class StoryItemStateful extends StatefulWidget {
  final String username;
  final bool isAddStory;
  final VoidCallback? onTap;

  const StoryItemStateful({
    super.key,
    required this.username,
    this.isAddStory = false,
    this.onTap,
  });

  @override
  State<StoryItemStateful> createState() => _StoryItemStatefulState();
}

class _StoryItemStatefulState extends State<StoryItemStateful> {
  bool isViewed = false;
  bool isLoading = false;

  /// Menangani tap pada item story
  /// - Jika "Add Story", tampilkan loading → panggil callback
  /// - Jika bukan, toggle status `isViewed`
  void _handleTap() async {
    if (widget.isAddStory) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });

      widget.onTap?.call();
    } else {
      setState(() {
        isViewed = !isViewed;
      });

      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isAddStory
        ? Colors.grey
        : (isViewed ? Colors.grey : Colors.redAccent);

    return GestureDetector(
      onTap: _handleTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // =======================
          // Avatar Circle + Border
          // =======================
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
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
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : null,
                ),
              ),

              // ==============================
              // Floating "+" untuk Your Story
              // ==============================
              if (widget.isAddStory && !isLoading)
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
                    child: PhosphorIcon(
                      PhosphorIcons.plus(),
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 4),

          // ==================
          // Username Text
          // ==================
          SizedBox(
            width: 64,
            child: Text(
              widget.isAddStory
                  ? (isLoading ? "Adding..." : "Your Story")
                  : "${widget.username} (Stateful)",
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
