import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:phosphor_flutter/phosphor_flutter.dart'; 

class PostSection extends StatefulWidget {
  const PostSection({super.key});

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  final String apiKey = "47220505-64172cbb87f4bd186a5093ef1";
  Map<String, dynamic>? post;

  // Tambahkan state untuk tombol Follow, Like, dan Comment
  bool isFollowing = false;
  bool isLiked = false;
  int likeCount = 1311; // Misalnya jumlah like awal

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  Future<void> fetchPost() async {
    final response = await http.get(
        Uri.parse("https://pixabay.com/api/?key=$apiKey&image_type=photo"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        post = data["hits"].isNotEmpty ? data["hits"][0] : null; // Ambil hanya 1 foto
      });
    } else {
      throw Exception("Failed to load post");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column( // Tidak perlu Scaffold di sini
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bagian Username, Suggested, dan Tombol Follow
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
                radius: 20,
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "itadaikimanis",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.verified, color: Colors.blue, size: 16),
                    ],
                  ),
                  Text(
                    "Suggested for you",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: isFollowing ? Colors.blue : Colors.white,
                  side: const BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isFollowing = !isFollowing; // Toggle follow state
                  });
                },
                child: Text(
                  isFollowing ? "Following" : "Follow",
                  style: TextStyle(
                    color: isFollowing ? Colors.white : Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Gambar Postingan dari API
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            post!["largeImageURL"],
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
        ),
        const SizedBox(height: 8),
        // Bagian Like dan Comment
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: PhosphorIcon(
                      isLiked 
                          ? PhosphorIconsFill.heart // Ikon full merah saat liked
                          : PhosphorIconsRegular.heart, // Ikon outline saat unliked
                      color: isLiked ? Colors.red : Colors.black, // Warna merah saat liked
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked; // Toggle like state
                        likeCount += isLiked ? 1 : -1; // Tambah atau kurangi jumlah like
                      });
                    },
                  ),
                  Text(
                    likeCount.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 12), // Jarak antar grup ikon
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const PhosphorIcon(
                      PhosphorIconsRegular.chatTeardrop,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      // Tampilkan pesan saat komentar ditekan
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Comment pressed"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  const Text(
                    "5", // Jumlah komentar statis
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),


        const SizedBox(height: 8),
        // Bagian Caption
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "itadaikimanis",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Pada akhirnya, ini semua, hanyalah ujian sementara walaupun kita hidup di negeri dongeng.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "1 month ago",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey, height: 24),
      ],
    );
  }
}