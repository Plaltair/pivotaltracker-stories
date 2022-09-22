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

  bool _asc = false;

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
            backgroundColor: Colors.blue,
            stretch: true,
            surfaceTintColor: Colors.blue,
            title: const Text(
              'Stories',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                tooltip: "Search",
                onPressed: () {
                  context.goNamed("Search", extra: _stories);
                },
                icon: const Icon(
                  Icons.search_sharp,
                  color: Colors.white,
                ),
              ),
              IconButton(
                tooltip: "Filter by date",
                onPressed: () {
                  setState(() {
                    _asc = !_asc;
                  });
                },
                icon: Icon(
                  _asc ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Colors.white,
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
                  : _asc
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
