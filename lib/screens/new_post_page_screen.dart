import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'explore_screen.dart';
import 'profil_screen.dart';
import 'home_page_screen.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  final TextEditingController _descriptionController = TextEditingController();

  int _currentIndex = 0;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // Fungsi untuk mengambil gambar dari kamera
  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_selectedImage != null) {
                String description = _descriptionController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Post berhasil dibuat! Deskripsi: $description')),
                );

                setState(() {
                  _selectedImage = null;
                  _descriptionController.clear();
                });

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Silakan tambahkan gambar terlebih dahulu!')),
                );
              }
            },
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Bagian Foto Utama
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => _showImagePickerOptions(context),
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                        size: 50,
                      ),
              ),
            ),
          ),
          // Input untuk Deskripsi (hanya muncul jika ada gambar)
          if (_selectedImage != null)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Tambahkan deskripsi...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExploreScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
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
            icon: _navBarIcon(PhosphorIconsRegular.house, PhosphorIconsBold.house, 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navBarIcon(PhosphorIconsRegular.magnifyingGlass, PhosphorIconsBold.magnifyingGlass, 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navBarIcon(PhosphorIconsRegular.plusSquare, PhosphorIconsBold.plusSquare, 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navBarIcon(PhosphorIconsRegular.userCircle, PhosphorIconsBold.userCircle, 3),
            label: '',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 32,
      ),
    );
  }

  Widget _navBarIcon(IconData regularIcon, IconData boldIcon, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: PhosphorIcon(
        _currentIndex == index ? boldIcon : regularIcon,
        size: 32,
        color: Colors.black,
      ),
    );
  }

  // Menampilkan opsi untuk memilih gambar
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil dari Kamera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}