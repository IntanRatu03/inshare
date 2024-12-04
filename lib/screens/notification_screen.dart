import 'package:flutter/material.dart';
import 'post_detail_page_screen.dart'; // Import halaman PostDetailPage

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
      ),
      body: ListView(
        children: [
          // Notifikasi Baru
          NotificationSection(
            sectionTitle: 'New',
            notifications: [
              NotificationItem(
                username: 'Farhan312',
                action: 'liked your photo.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile1.jpg',
                postImage: 'assets/images/dummy_post2.jpg',
              ),
              NotificationItem(
                username: 'Tiflan_chan',
                action: 'comment in your post.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile2.jpg',
                postImage: 'assets/images/dummy_post2.jpg',
                comment: 'Hari ini panas sekali ya',
              ),
              NotificationItem(
                username: 'Rika_resres',
                action: 'started following you.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile3.jpg',
                followButton: true,
              ),
            ],
          ),
          // Notifikasi Kemarin
          NotificationSection(
            sectionTitle: 'Yesterday',
            notifications: [
              NotificationItem(
                username: 'aurauran312',
                action: 'liked your photo.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile4.jpg',
                postImage: 'assets/images/dummy_post2.jpg',
              ),
              NotificationItem(
                username: 'Jerico32',
                action: 'comment in your post.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile5.jpg',
                postImage: 'assets/images/dummy_post2.jpg',
                comment: 'Ini di mana?',
              ),
              NotificationItem(
                username: 'Nikasari21',
                action: 'started following you.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile6.jpg',
                followButton: true,
              ),
            ],
          ),
          // Notifikasi Bulan Ini
          NotificationSection(
            sectionTitle: 'This month',
            notifications: [
              NotificationItem(
                username: 'Velicya31',
                action: 'liked your photo.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile7.jpg',
                postImage: 'assets/images/dummy_post2.jpg',
              ),
              NotificationItem(
                username: 'Atikah_ani',
                action: 'comment in your post.',
                time: '1h',
                profileImage: 'assets/images/dummy_profile8.jpg',
                postImage: 'assets/images/dummy_post2.jpg',
                comment: 'Mayan sih',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String sectionTitle;
  final List<NotificationItem> notifications;

  const NotificationSection({super.key, 
    required this.sectionTitle,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ...notifications,
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String username;
  final String action;
  final String time;
  final String profileImage;
  final String? postImage;
  final String? comment;
  final bool followButton;

  const NotificationItem({super.key, 
    required this.username,
    required this.action,
    required this.time,
    required this.profileImage,
    this.postImage,
    this.comment,
    this.followButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (postImage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailPage(
                username: username,
                postImage: postImage!,
                
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(profileImage),
              radius: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' $action'),
                      ],
                    ),
                  ),
                  if (comment != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        comment!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            if (postImage != null)
              Image.asset(
                postImage!,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            if (followButton)
              TextButton(
                onPressed: () {},
                child: const Text('Follow'),
              ),
          ],
        ),
      ),
    );
  }
}