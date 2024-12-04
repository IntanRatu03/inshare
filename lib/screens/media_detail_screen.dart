import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'comment_screen.dart'; // Import CommentScreen

class MediaDetailScreen extends StatefulWidget {
  final String mediaUrl;
  final String caption;
  final String userId;
  final String tag;
  final DateTime createdAt;

  const MediaDetailScreen({
    super.key,
    required this.mediaUrl,
    required this.caption,
    required this.userId,
    required this.tag,
    required this.createdAt,
  });

  @override
  State<MediaDetailScreen> createState() => _MediaDetailScreenState();
}

class _MediaDetailScreenState extends State<MediaDetailScreen> {
  int likes = 1234; 
  bool isLiked = false; 
  bool isFollowing = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const PhosphorIcon(PhosphorIconsRegular.arrowLeft),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User profile information
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/dummy_profile1.jpg'),
                  radius: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userId,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Suggested for you',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: isFollowing ? Colors.grey : Colors.blue,
                    minimumSize: const Size(80, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isFollowing = !isFollowing;
                    });
                  },
                  child: Text(
                    isFollowing ? 'Unfollow' : 'Follow',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Media Image - Full Width
          Image.network(
            widget.mediaUrl,
            width: double.infinity,
            height: 360,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Like and Comment icons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isLiked) {
                            likes--;
                          } else {
                            likes++;
                          }
                          isLiked = !isLiked;
                        });
                      },
                      child: Icon(
                        isLiked
                            ? PhosphorIconsFill.heart
                            : PhosphorIconsRegular.heart,
                        color: isLiked ? Colors.red : Colors.black,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('$likes'),
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () {
                        // Navigate to CommentPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentPage(),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          PhosphorIcon(PhosphorIconsRegular.chatCircle),
                          SizedBox(width: 8),
                          Text('5'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // User ID
                Text(
                  widget.userId,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Tags
                Row(
                  children: [
                    Text(
                      '#${widget.tag}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Date of creation
                Text(
                  '${widget.createdAt.toLocal()}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16)
              ],
            ),
          ),
        ],
      ),
    );
  }
}