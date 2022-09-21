import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pivotaltracker_stories/models/story_model.dart';

const _url =
    "https://www.pivotaltracker.com/services/v5/projects/2116794/stories";

Future<List<StoryModel>> getStories() async {
  http.Response response = await http.get(Uri.parse(_url));

  return List<StoryModel>.from(
      jsonDecode(response.body).map((e) => StoryModel.fromJson(e)));
}
