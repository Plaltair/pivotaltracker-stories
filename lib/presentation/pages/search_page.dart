import 'package:flutter/material.dart';
import 'package:pivotaltracker_stories/models/story_model.dart';
import 'package:pivotaltracker_stories/widgets/search_field.dart';
import 'package:pivotaltracker_stories/widgets/stories_list.dart';

class SearchPage extends StatefulWidget {
  final List<StoryModel> stories;
  const SearchPage({Key? key, required this.stories}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<StoryModel> _filter = [];
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SearchField(
            onChange: (value) {
              setState(() {
                _searchText = value;
                if (value.length > 3) {
                  _filter = widget.stories
                      .where((element) =>
                          element.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          (element.description != null &&
                              element.description!
                                  .toLowerCase()
                                  .contains(value.toLowerCase())))
                      .toList();
                }
              });
            },
          ),
          if (_searchText.length > 3) ...[
            const SizedBox(
              height: 40,
            ),
            StoriesList(stories: _filter),
          ]
        ],
      ),
    );
  }
}
