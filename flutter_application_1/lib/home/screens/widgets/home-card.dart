import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/models/story.dart';

class HomeCard extends StatelessWidget {
  final StoryDTO story;
  const HomeCard({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      height: 120,
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey..shade800, width: 2),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipOval(child: Image.network(story.image)),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: buildingStoryInformation(story),
          ),
        ],
      ),
    );
  }
}

Widget buildingStoryInformation(StoryDTO story) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        story.name,
        style: TextStyle(fontSize: 20),
      ),
      Text(
        story.species,
        style: TextStyle(fontSize: 15)
        ),
      Text(
        story.status,
        style: TextStyle(fontSize: 15)
        ),
    ],
  );
}
