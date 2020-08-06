import 'package:flutter/material.dart';

class Training extends StatefulWidget {
  @override
  TrainingState createState() => TrainingState();
}

class TrainingState extends State<Training> {

  List<String> _listImages = [
    "images/a.jpg",
    "images/b.jpg",
    "images/c.jpg",
    "images/d.jpg",
    "images/e.jpg",
    "images/f.jpg",
    "images/g.jpg",
    "images/h.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          // margin
          const SizedBox(height: 60),

          // Heading
          Text(
            "Training",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF409ded),
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),

          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: _listImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20, ),
                itemBuilder: (_, index) {
                  return Image.asset(_listImages[index], fit: BoxFit.cover, width: 100, height: 100);
                },
              ),
            ),
          )
        ]
      )
    );
  }

}