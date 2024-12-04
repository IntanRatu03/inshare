import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostItem extends StatefulWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  // Menyimpan status apakah postingan sudah di-like atau belum
  bool isLiked = false;

  // Fungsi untuk mengubah status like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked; // Mengubah status like/unlike
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Postingan
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.post.profileImageUrl),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.post.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LexendDeca',
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  backgroundColor: const Color.fromARGB(255, 234, 229, 229),
                ),
                child: const Text(
                  'Follow',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'LexendDeca',
                  ),
                ),
              ),
            ],
          ),
          subtitle: const Text(
            'Suggested for you',
            style: TextStyle(fontFamily: 'LexendDeca'),
          ),
        ),
        // Gambar Postingan
        Image.network(widget.post.postImageUrl),
        // Statistik Postingan
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Ikon Like dengan interaksi
              IconButton(
                icon: Icon(
                  isLiked
                      ? Icons.favorite
                      : Icons.favorite_border, // Ganti ikon berdasarkan status
                  color: isLiked
                      ? Colors.red
                      : Colors.black, // Warna merah jika di-like
                ),
                onPressed: toggleLike, // Panggil fungsi toggleLike
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chat_bubble_outline),
              const SizedBox(width: 10),
              const Spacer(),
              const Icon(Icons.bookmark_border),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${isLiked ? widget.post.likes + 1 : widget.post.likes} likes', // Perbarui jumlah likes
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'LexendDeca',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${widget.post.username} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'LexendDeca',
                  ),
                ),
                TextSpan(
                  text: widget.post.caption,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'LexendDeca',
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          child: Text(
            '1 month ago',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: 'LexendDeca',
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}