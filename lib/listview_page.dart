import 'package:flutter/material.dart';

class ListviewPage extends StatelessWidget {
  const ListviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var myItems = [
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877659/bdbfqc16l5k2nhaoc99u.jpg",
        "title": "Android",
      },
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877680/ilnb8qjctbxo2xnrtylf.png",
        "title": "Python",
      },
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877702/oxrvaljxkohs9szceqqt.png",
        "title": "C++",
      },
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877719/agcgvuve4rkmdh6bd5qf.png",
        "title": "PHP",
      },
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877735/k5bhru2686zxbjednwwr.png",
        "title": "Ruby",
      },
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877758/tafqmkrghogfxucf1qrc.png",
        "title": "Java",
      },
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877784/jscq8pzbrs3kuaktersp.png",
        "title": "Rails",
      },
      {
        "img":
            "https://res.cloudinary.com/dvsuhuocv/image/upload/v1736877809/db9p9tmaiikif6zjatft.jpg",
        "title": "Ajax",
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: myItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Image.network(myItems[index]['img']!, height: 100, width: 100),
                Text(myItems[index]['title']!),
              ],
            ),
          );
        },
      ),
    );
  }
}
