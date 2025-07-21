import 'package:flutter/material.dart';
import 'package:flutter_instagram_feed/core/assets/assets.gen.dart';
import 'package:flutter_instagram_feed/presentation/widgets/post_item.dart';
import 'package:flutter_instagram_feed/presentation/widgets/story_stateful/story_bar_stateful.dart';
import 'package:flutter_instagram_feed/presentation/widgets/story_stateless/story_bar_stateless.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, String>> dummyPosts = [
    {
      "username": "alex",
      "caption": "Chasing sunsets 🌇 #vibes",
      "imageUrl": "https://picsum.photos/seed/1/500/500",
    },
    {
      "username": "bella",
      "caption": "Coffee and calm ☕✨",
      "imageUrl": "https://picsum.photos/seed/2/500/500",
    },
    {
      "username": "michael",
      "caption": "Weekend mood 🍃",
      "imageUrl": "https://picsum.photos/seed/3/500/500",
    },
    {
      "username": "nina",
      "caption": "Ocean breeze & peace 🌊",
      "imageUrl": "https://picsum.photos/seed/4/500/500",
    },
    {
      "username": "leo",
      "caption": "Late night coding 🧠💻",
      "imageUrl": "https://picsum.photos/seed/5/500/500",
    },
    {
      "username": "claire",
      "caption": "Morning walks > everything 🚶‍♀️",
      "imageUrl": "https://picsum.photos/seed/6/500/500",
    },
    {
      "username": "david",
      "caption": "This city never sleeps 🌃",
      "imageUrl": "https://picsum.photos/seed/7/500/500",
    },
    {
      "username": "sasha",
      "caption": "Sundays are for self-care 💆‍♀️💖",
      "imageUrl": "https://picsum.photos/seed/8/500/500",
    },
    {
      "username": "ryan",
      "caption": "Work hard. Rest harder. 😴",
      "imageUrl": "https://picsum.photos/seed/9/500/500",
    },
    {
      "username": "tina",
      "caption": "Good vibes only ☀️",
      "imageUrl": "https://picsum.photos/seed/10/500/500",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _AppBarWidget(),
      body: ListView(
        children: [
          const SizedBox(height: 8.0),
          // ====================================================
          // PERBANDINGAN STORY BAR STATEFUL VS STATELESS
          // ====================================================

          // ✅ StoryBarStateful
          //
          // - Setiap item (`StoryItemStateful`) mengelola state-nya sendiri
          // - Cocok untuk item yang punya interaksi lokal seperti animasi, loading, toggle sendiri
          // - Tidak tergantung parent untuk menyimpan status `isViewed`
          //
          //  Misalnya: tekan `Your Story`, akan muncul loading di dalam item tersebut saja.
          // const StoryBarStateful(),

          // ❌ StoryBarStateless
          //
          // - Semua state dikontrol oleh parent (`StoryBarStateless`)
          // - Tiap item (`StoryItemStateless`) hanya menampilkan status berdasarkan input props
          // - Perubahan status harus di-trigger oleh parent dengan `setState`
          //
          //  Misalnya: tekan story → parent ubah data → rebuild semua list.
          const StoryBarStateless(),

          // ====================================================
          // LIST POST (DUMMY)
          // ====================================================
          ...dummyPosts.map(
            (post) => PostItem(
              username: post['username'] ?? '',
              caption: post['caption'] ?? '',
              imageUrl: post['imageUrl'] ?? '',
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(36);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 8),
        height: preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ===============================
            // Kiri: Logo + Icon Dropdown ▼
            // ===============================
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.images.logo.path,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                _buildIconButton(
                  icon: PhosphorIcons.caretDown(),
                  size: 14,
                  onAction: () => debugPrint('menu'),
                ),
              ],
            ),

            // ===============================
            // Kanan: Icon ❤️ dan 📩
            // ===============================
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: Offset(0, 1),
                  child: _buildIconButton(
                    icon: PhosphorIcons.heart(),
                    onAction: () => debugPrint('❤️ Like'),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 1),
                  child: _buildIconButton(
                    icon: PhosphorIcons.chatCircleText(),
                    onAction: () => debugPrint('📩 Message'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onAction,
    double size = 20.0,
  }) {
    return IconButton(
      onPressed: onAction,
      icon: PhosphorIcon(
        icon,
        size: size,
        color: Colors.black,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      // mengatur kepadatan visual (lebih padat -1 horizontal & vertical)
      visualDensity: VisualDensity.compact,
    );
  }
}
