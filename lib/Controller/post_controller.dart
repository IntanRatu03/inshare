import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostController extends GetxController {
  final String apiKey = "47220505-64172cbb87f4bd186a5093ef1";

  // State reaktif
  var post = {}.obs; // Data postingan
  var isFollowing = false.obs; // Status follow
  var isLiked = false.obs; // Status like
  var likeCount = 1311.obs; // Jumlah like

  @override
  void onInit() {
    super.onInit();
    fetchPost(); // Panggil fetchPost saat controller diinisialisasi
  }

  Future<void> fetchPost() async {
    final response = await http.get(
      Uri.parse("https://pixabay.com/api/?key=$apiKey&image_type=photo"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["hits"].isNotEmpty) {
        post.value = data["hits"][0]; // Ambil satu data
      }
    } else {
      throw Exception("Failed to load post");
    }
  }

  // Fungsi toggle follow
  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  // Fungsi toggle like
  void toggleLike() {
    isLiked.value = !isLiked.value;
    likeCount.value += isLiked.value ? 1 : -1;
  }
}