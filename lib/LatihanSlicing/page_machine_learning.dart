import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageMachineLearning extends StatefulWidget {
  const PageMachineLearning({Key? key});

  @override
  State<PageMachineLearning> createState() => _PageMachineLearningState();
}

class _PageMachineLearningState extends State<PageMachineLearning> {
  final List<String> cardTitles = [
    'Machine Learning',
    'Getting Started with ML',
    'Introduction to Machine Learning',
    'PG in Machine Learning',
    'Machine Learning',
    'Machine Learning Course',
  ];

  final List<String> imagePaths = [
    'assests/gambar/image1.jpeg',
    'assests/gambar/image2.jpeg',
    'assests/gambar/image3.jpeg',
    'assests/gambar/mage4.jpeg',
    'assests/gambar/image5.jpeg',
    'assests/gambar/image6.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Machine Learning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: cardTitles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: CardListItem(
                title: cardTitles[index],
                rating: 4.5,
                viewers: 1000,
                image: AssetImage(imagePaths[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  final String title;
  final double rating;
  final int viewers;
  final ImageProvider image;

  const CardListItem({
    required this.title,
    required this.rating,
    required this.viewers,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 5),
                              Text(
                                rating.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            '10.5k learners',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
