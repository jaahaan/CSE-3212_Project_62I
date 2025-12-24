import 'package:flutter/material.dart';

class SingleItemPage extends StatelessWidget {
  final img, title;
  const SingleItemPage({super.key, required this.img, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Single Item Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Card(
            child: Column(
              children: [
                Image.network(img, height: 200, width: 200),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
