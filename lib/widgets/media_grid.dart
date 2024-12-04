import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/media_detail_screen.dart';

class MediaGrid extends StatefulWidget {
  const MediaGrid({super.key});

  @override
  _MediaGridState createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  final String apiKey = '47220505-64172cbb87f4bd186a5093ef1';
  List<Map<String, dynamic>> mediaList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    try {
      // Fetch images only
      final imageResponse = await http.get(
        Uri.parse('https://pixabay.com/api/?key=$apiKey&image_type=photo'),
      );
      final imageData = json.decode(imageResponse.body);

      // Create a list of image data
      final List<Map<String, dynamic>> fetchedMedia = imageData['hits'].map<Map<String, dynamic>>((item) {
        return {
          'type': 'image',
          'url': item['webformatURL'],
          'user': item['user'],
          'tags': item['tags'],
        };
      }).toList();

      setState(() {
        mediaList = fetchedMedia;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching media: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView to allow scrolling
        child: GridView.builder(
          shrinkWrap: true, // Ensures the grid doesn't take up more space than needed
          physics: const NeverScrollableScrollPhysics(), // Disables the scrolling behavior of GridView itself
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: 60, // Display 60 rows of images
          itemBuilder: (context, index) {
            final media = mediaList[index % mediaList.length]; // Loop through images if there are less than 60

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaDetailScreen(
                      mediaUrl: media['url'],
                      userId: media['user'],
                      caption: media['url'],
                      createdAt: DateTime.now(),
                      tag: media['tags'],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.network(
                    media['url'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}