import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Uint8List? _imageBytes;
  String? _fileExtension;
  String? _fileName;

  final _supabase = Supabase.instance.client;
  bool _isLoading = false;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();

      setState(() {
        _imageBytes = bytes;
        _fileExtension = image.name.split('.').last;
        _fileName = image.name;
      });
    }
  }

  Future uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    if (_imageBytes == null) return;

    final fileName =
        'uploads/${DateTime.now().millisecondsSinceEpoch}.$_fileExtension';

    try {
      await Supabase.instance.client.storage
          .from('images')
          .uploadBinary(
            fileName,
            _imageBytes!,
            fileOptions: FileOptions(contentType: 'image/$_fileExtension'),
          );
      String imageUrl = getPublicImageUrl(fileName);
      print(imageUrl);
      final user = _supabase.auth.currentUser;
      if (user != null) {
        // Save imageUrl in profiles table
        await _supabase
            .from('profiles')
            .update({
              'avatar_url': imageUrl, // column to update
            })
            .eq('id', user.id);
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Uploaded")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    setState(() {
      _isLoading = false;
    });
  }

  String getPublicImageUrl(String path) {
    return Supabase.instance.client.storage.from('images').getPublicUrl(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Upload")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageBytes != null
                ? Text("$_fileName Selected")
                : Text("No Image Selected"),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadImage,
              child: _isLoading ? Text("Uploading...") : Text("Upload Image"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
