import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pivotaltracker_stories/models/story_model.dart';

class InfoDialog extends StatelessWidget {
  final StoryModel story;
  const InfoDialog({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(story.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                "Created on: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(DateFormat("yyyy/MM/dd HH:mm")
                  .format(DateTime.parse(story.createdAt)))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Updated on: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(DateFormat("yyyy/MM/dd HH:mm")
                  .format(DateTime.parse(story.updatedAt)))
            ],
          ),
          if (story.priority != null) ...[
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Priority: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  story.priority!,
                )
              ],
            )
          ],
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Status: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                story.currentState,
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ],
      ),
    );
  }
}
