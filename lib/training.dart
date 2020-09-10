import 'dart:convert';
import 'package:flutter/material.dart';

class Training extends StatefulWidget {
  @override
  TrainingState createState() => TrainingState();
}

class TrainingState extends State<Training> {

  List<String> _listImages = [];
  List<String> _listNames = [];

  Future _initImages() async {
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.gif'))
        .toList();

    setState(() {
      _listImages = imagePaths;
    });
  }

  @override
  void initState() {
    _initImages().then((value){
      print('_initImages() done.');
      for(var name in _listImages)  {
        name = name.replaceAll("images/", "");
        name = name.replaceAll(".gif", "");
        name = name.replaceAll("_", " ");
        name = '${name[0].toUpperCase()}${name.substring(1)}';
        _listNames.add(name);
      }
    });
    super.initState();
  }

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
          SizedBox(height: 10),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: _listImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20, ),
                itemBuilder: (_, index) {
                  return Container(
                      child: Column(
                        children: [
                          Text(_listNames[index]),
                          Image.asset(_listImages[index], fit: BoxFit.cover, width: 200, height: 150),
                        ],
                      )
                  );
                },
              ),
            ),
          )
        ]
      )
    );
  }

}