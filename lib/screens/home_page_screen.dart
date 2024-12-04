import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';
import 'new_post_page_screen.dart';
import 'explore_screen.dart';
import 'comment_screen.dart';
import 'notification_screen.dart';
import 'profil_screen.dart';
import 'storypage_screen.dart';
import '../Controller/post_controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StorySection(), // Menambahkan StorySection ke dalam halaman utama
            PostSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewPostPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExploreScreen()),
            );
          } else if (index == 3) {
            // Navigasi ke halaman Profil ketika ikon profil ditekan
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()), // Ganti dengan halaman profil yang benar
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: PhosphorIcon(
                _currentIndex == 0
                    ? PhosphorIconsBold.house
                    : PhosphorIconsRegular.house,
                size: 32,
                color: Colors.black,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: PhosphorIcon(
                _currentIndex == 1
                    ? PhosphorIconsBold.magnifyingGlass
                    : PhosphorIconsRegular.magnifyingGlass,
                size: 32,
                color: Colors.black,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: PhosphorIcon(
                _currentIndex == 2
                    ? PhosphorIconsBold.plusSquare
                    : PhosphorIconsRegular.plusSquare,
                size: 32,
                color: Colors.black,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: PhosphorIcon(
                _currentIndex == 3
                    ? PhosphorIconsBold.userCircle
                    : PhosphorIconsRegular.userCircle,
                size: 32,
                color: Colors.black,
              ),
            ),
            label: '',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 32,
      ),
    );
  }
}
class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {"name": "Your Story", "images": "assets/images/Profile1.png"},
      {"name": "_fachrijuliandaa", "images": "assets/images/Profile2.jpg"},
      {"name": "dikal_ajah", "images": "assets/images/Profile3.jpg"},
      {"name": "sala_hai", "images": "assets/images/dummy_profile4.jpg"},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Ganti teks dengan logo
              Image.asset(
                'assets/images/Insharelogo.png', 
                height: 40, 
              ),
              IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Navigasi ke halaman notification.dart saat ikon favorit ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotificationPage()), // Navigasi ke NotificationPage
                    );
                  }),
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
              return GestureDetector(
                onTap: () {
                  if (stories[index]["name"] == "Your Story") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StoryPage (),
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Agar elemen terpusat
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Menjaga alignment di tengah
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
                            backgroundImage:
                                AssetImage(stories[index]["images"]!),
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
                    const SizedBox(
                      height:
                          6), // Menambahkan sedikit jarak antar gambar dan teks
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
                      textAlign:
                          TextAlign.center, // Pastikan teks berada di tengah
                    ),
                  ),
                ],
              )
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(width: 16), // Jarak antar item di ListView
          ),
        ),
      ],
    );
  }
}

class PostSection extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.post.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/dummy_profile8.jpg'),
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
                Obx(() {
                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: controller.isFollowing.value
                          ? Colors.blue
                          : Colors.white,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: controller.toggleFollow,
                    child: Text(
                      controller.isFollowing.value ? "Following" : "Follow",
                      style: TextStyle(
                        color: controller.isFollowing.value
                            ? Colors.white
                            : Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              controller.post["largeImageURL"],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Obx(() {
                  return IconButton(
                    icon: PhosphorIcon(
                      controller.isLiked.value
                          ? PhosphorIconsFill.heart
                          : PhosphorIconsRegular.heart,
                      color: controller.isLiked.value ? Colors.red : Colors.black,
                      size: 24,
                    ),
                    onPressed: controller.toggleLike,
                  );
                }),
                Obx(() {
                  return Text(
                    controller.likeCount.value.toString(),
                    style: const TextStyle(fontSize: 14),
                  );
                }),
                const SizedBox(width: 12),
                IconButton(
                  icon: const PhosphorIcon(
                    PhosphorIconsRegular.chatTeardrop,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                  // Navigasi ke CommentPage
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentPage(),
                          ),
                        );
                  }
                ),
                const Text(
                  "5", // Jumlah komentar statis
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
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
        ],
      );
    });
  }
}