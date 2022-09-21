import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 20,
          ),
          SearchField(
            onChange: (value) {
              setState(() {
                _searchText = value;
                if (value.length > 2) {
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
          if (_searchText.length > 2) ...[
            const SizedBox(
              height: 40,
            ),
            StoriesList(stories: _filter),
          ] else ...[
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "Write more than two characters.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
