import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pivotaltracker_stories/models/story_model.dart';
import 'package:pivotaltracker_stories/requests/requests.dart';
import 'package:pivotaltracker_stories/widgets/stories_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StoryModel>? _stories;
  bool _loading = true;

  bool _filter = false;

  @override
  void initState() {
    super.initState();
    _getStories();
  }

  void _getStories() async {
    _stories = await getStories();
    _stories!.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            stretch: true,
            surfaceTintColor: Colors.blue,
            title: const Text('Stories'),
            centerTitle: false,
            actions: [
              IconButton(
                tooltip: "Search",
                onPressed: () {
                  context.goNamed("Search", extra: _stories);
                },
                icon: const Icon(
                  Icons.search_sharp,
                ),
              ),
              IconButton(
                tooltip: "Filter by date",
                onPressed: () {
                  setState(() {
                    _filter = !_filter;
                  });
                },
                icon: const Icon(
                  Icons.sort,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : _filter
                      ? StoriesList(
                          stories: _stories!
                            ..sort(
                              (a, b) => a.updatedAt.compareTo(b.updatedAt),
                            ),
                        )
                      : StoriesList(
                          stories: _stories!
                            ..sort(
                              (a, b) => b.updatedAt.compareTo(a.updatedAt),
                            ),
                        ),
            ),
          )
        ],
      ),
    );
  }
}