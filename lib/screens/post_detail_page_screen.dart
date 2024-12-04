import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart'; 
import 'comment_screen.dart'; // Import halaman komentar Anda

class PostDetailPage extends StatefulWidget {
  final String username;
  final String postImage;

  const PostDetailPage({super.key, 
    required this.username,
    required this.postImage,
  });

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool isLiked = false; // Status like
  int likes = 1311; // Jumlah like

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Panel Foto Profil dan Username
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/dummy_profile2.jpg'), // Foto profil dari assets
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Gambar (Square)
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width, // 1:1 (square)
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.postImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Ikon Interaksi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Icon Like
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
                // Icon Comment
                GestureDetector(
                  onTap: () {
                    // Navigate to CommentPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentPage(), // Ganti dengan halaman komentar Anda
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      PhosphorIcon(PhosphorIconsRegular.chatCircle),
                      SizedBox(width: 8),
                      Text('5'), // Misalnya ada 5 komentar, ganti sesuai dengan jumlah komentar yang relevan
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Caption dan Informasi Tambahan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '${widget.username} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            'Pada akhirnya, ini semua, hanyalah ujian sementara walaupun kita hidup di negeri dongeng.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1 month ago',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
