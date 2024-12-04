import 'package:flutter/material.dart';
import 'package:inshare_uas/screens/home_page_screen.dart';
import 'editprofil_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'login_screen.dart';
import 'explore_screen.dart';
import 'new_post_page_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // Inisialisasi currentIndex

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Nanad_manda',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigasi ke LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const PhosphorIcon(
                PhosphorIconsRegular.signOut,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
               padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                children: [
                  const Row(
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/dummy_post1.jpg',
                        ),
                      ),
                      SizedBox(width: 16),
                      // Stats
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StatColumn(title: '1', subtitle: 'Posts'),
                            StatColumn(title: '432', subtitle: 'Followers'),
                            StatColumn(title: '324', subtitle: 'Following'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Name and Bio
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nadya Amanda',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '@Nanad_manda',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text('Ikan apa yang suka jalan-jalan?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Edit Profile Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigasi ke halaman Edit Profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                      ),
                      child: Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            // Tabs (Posts)
              const Padding(
              padding:  EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.grid_on, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Posts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            // Post Grid
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 3, // Sesuaikan dengan jumlah postingan
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/dummy_post2.jpg', // Ganti dengan URL gambar postingan Anda
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
              ),
            ),
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
            // New Post
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewPostPage()),
            );
          } else if (index == 1) {
            // Explore
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExploreScreen()),
            );
          } else if (index == 0) {
            // Navigasi ke halaman Beranda ketika ikon beranda ditekan
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Ganti dengan halaman beranda yang benar
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

class StatColumn extends StatelessWidget {
  final String title;
  final String subtitle;

  const StatColumn({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}