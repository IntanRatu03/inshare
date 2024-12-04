import 'package:flutter/material.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {"name": "Your Story", "images": "assets/images/Profile1.png"},
      {"name": "_fachrijuliandaa", "images": "assets/images/Profile2.jpg"},
      {"name": "dikal_ajah", "images": "assets/images/Profile3.jpg"},
      {"name": "sala_hai", "image": "assets/images/dummy_profile4.jpg"},
    ];

    return Column(
      children: [
        // Header dengan teks "Inshare" dan ikon favorit
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Inshare",
                style: TextStyle(
                  fontFamily: 'Cursive',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Aksi ketika ikon favorit ditekan
                  print("Favorite icon clicked");
                },
              ),
            ],
          ),
        ),
        // Bagian story
        Container(
          height: 110, // Sesuaikan dengan tinggi yang diinginkan
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min, // Agar elemen terpusat
                crossAxisAlignment: CrossAxisAlignment.center, // Menjaga alignment di tengah
                children: [
                  Stack(
                    children: [
                      // Border untuk avatar
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: index == 0
                            ? Colors.blueAccent
                            : Colors.red, // Warna border
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(stories[index][2]!),
                        ),
                      ),
                      if (stories[index]["name"] == "Your Story")
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6), // Menambahkan sedikit jarak antar gambar dan teks
                  SizedBox(
                    width: 80, // Membatasi lebar teks
                    child: Text(
                      stories[index]["name"]!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'LexendDeca',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center, // Pastikan teks berada di tengah
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16), // Jarak antar item di ListView
          ),
        ),
      ],
    );
  }
}