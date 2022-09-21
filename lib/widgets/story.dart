import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pivotaltracker_stories/models/story_model.dart';
import 'package:intl/intl.dart';
import 'package:pivotaltracker_stories/presentation/dialogs/info_dialog.dart';
import 'package:pivotaltracker_stories/widgets/label.dart';
import 'package:url_launcher/url_launcher.dart';

class Story extends StatelessWidget {
  final StoryModel story;
  const Story({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey[300]!,
              blurRadius: 10,
              spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd")
                          .format(DateTime.parse(story.updatedAt)),
                      style: const TextStyle(fontSize: 12),
                    ),
                    if (story.priority != null) ...[
                      const SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        story.priority!,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                    const SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      toBeginningOfSentenceCase(story.currentState) ?? "",
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return InfoDialog(story: story);
                      });
                },
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (story.description != null)
            Text(
              story.description!,
              style: const TextStyle(fontSize: 15),
            ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (StoryLabel label in story.labels)
                Label(
                  label: label.name,
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              onPressed: () {
                launchUrl(Uri.parse(story.url));
              },
              child: const Text(
                "More",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
