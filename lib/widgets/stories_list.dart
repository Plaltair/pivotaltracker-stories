import 'package:flutter/material.dart';
import 'package:pivotaltracker_stories/models/story_model.dart';
import 'package:pivotaltracker_stories/widgets/story.dart';

class StoriesList extends StatelessWidget {
  final List<StoryModel> stories;
  const StoriesList({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (StoryModel story in stories) ...[
          Story(
            story: story,
          ),
          const SizedBox(
            height: 40,
          ),
        ]
      ],
    );
  }
}
