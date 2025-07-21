import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// PostItem menampilkan 1 post ala Instagram:
/// - Header (avatar, username)
/// - Gambar utama
/// - Tombol aksi (like, comment, share, save)
/// - Informasi like dan caption
class PostItem extends StatefulWidget {
  final String username;
  final String caption;
  final String imageUrl;

  const PostItem({
    super.key,
    required this.username,
    required this.caption,
    required this.imageUrl,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  // ========================
  // State untuk tombol like dan bookmark
  // ========================
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildImage(),
        _buildActions(),
        _buildLikes(),
        _buildCaption(),
        const SizedBox(height: 12),
      ],
    );
  }

  // ========================
  // Post Header (Avatar + Username)
  // ========================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[300],
            child: Text(
              widget.username[0].toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // ========================
  // Post Image
  // ========================
  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[200],
          child: const Center(child: Icon(Icons.broken_image)),
        ),
      ),
    );
  }

  // ========================
  // Likes Info
  // ========================
  Widget _buildLikes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        isLiked ? "You and others liked this" : "Liked by user123 and others",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // ========================
  // Caption
  // ========================
  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "${widget.username} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: widget.caption),
          ],
        ),
      ),
    );
  }

  // ========================
  // Action Buttons Row
  // ========================
  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          _buildIconButton(
            icon: PhosphorIcons.heart(
              isLiked ? PhosphorIconsStyle.bold : PhosphorIconsStyle.regular,
            ),
            color: isLiked ? Colors.red : Colors.black,
            onAction: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          _buildIconButton(
            icon: PhosphorIcons.chatCircle(),
            onAction: () {
              debugPrint("Comment tapped");
            },
          ),
          _buildIconButton(
            icon: PhosphorIcons.paperPlaneTilt(),
            onAction: () {
              debugPrint("Share tapped");
            },
          ),
          const Spacer(),
          _buildIconButton(
            // Bookmark toggle
            icon: PhosphorIcons.bookmarkSimple(
              isBookmarked
                  ? PhosphorIconsStyle.bold
                  : PhosphorIconsStyle.regular,
            ),
            onAction: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
            },
          ),
        ],
      ),
    );
  }

  // ========================
  // Reusable Icon Button (Kecil dan Padat)
  // Digunakan agar semua ikon konsisten gaya dan ukuran
  // ========================
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onAction,
    Color color = Colors.black,
    double size = 20.0,
  }) {
    return IconButton(
      onPressed: onAction,
      icon: PhosphorIcon(
        icon,
        size: size,
        color: color,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
    );
  }
}
