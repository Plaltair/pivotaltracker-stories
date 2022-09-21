import 'package:go_router/go_router.dart';
import 'package:pivotaltracker_stories/models/story_model.dart';
import 'package:pivotaltracker_stories/presentation/pages/home_page.dart';
import 'package:pivotaltracker_stories/presentation/pages/search_page.dart';

GoRouter _goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: "search",
          name: "Search",
          builder: (context, state) => SearchPage(
            stories: state.extra as List<StoryModel>,
          ),
        )
      ],
    )
  ],
);

GoRouter get goRouter => _goRouter;
