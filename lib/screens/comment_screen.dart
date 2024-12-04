import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart'; // Import Phosphor Icons

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'LexendDeca', // Menggunakan font Lexend Deca
      ),
      home: CommentPage(),
    );
  }
}

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  // List untuk menyimpan komentar dan waktu pengirimannya
  List<Map<String, dynamic>> comments = [];
  TextEditingController commentController = TextEditingController();

  // Fungsi untuk memformat waktu
  String formatTime(DateTime dateTime) {
    String hours = dateTime.hour.toString().padLeft(2, '0');
    String minutes = dateTime.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Widget commentTile(Map<String, dynamic> commentData) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/dummy_post1.jpg'), // Gambar profil
      ),
      title: const Text(
        'Nanad_manda',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(commentData['comment']),
      trailing: Text(
        formatTime(commentData['time']), // Format waktu pengiriman
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return commentTile(comments[index]);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/dummy_post1.jpg'), // Gambar profil
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Add Comment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Latar belakang biru
                    borderRadius: BorderRadius.circular(8), // Corner radius 8
                  ),
                  child: IconButton(
                    icon: const PhosphorIcon(
                      PhosphorIconsFill.paperPlaneRight, // Ikon kirim
                      color: Colors.white, // Warna ikon putih
                      size: 24, // Ukuran ikon
                    ),
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        setState(() {
                          // Menambahkan komentar dengan waktu sekarang
                          comments.add({
                            'comment': commentController.text,
                            'time': DateTime.now(), // Waktu saat komentar dikirim
                          });
                        });
                        commentController.clear(); // Mengosongkan input
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}