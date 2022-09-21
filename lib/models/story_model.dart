class StoryModel {
  int id;
  String createdAt;
  String updatedAt;
  String acceptedAt;
  String? priority;
  String name;
  String? description;
  String currentState;
  String url;
  List<StoryLabel> labels;

  StoryModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.acceptedAt,
    required this.priority,
    required this.name,
    required this.description,
    required this.currentState,
    required this.url,
    required this.labels,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json["id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      acceptedAt: json["accepted_at"],
      priority: json["story_priority"],
      name: json["name"],
      description: json["description"],
      currentState: json["current_state"],
      url: json["url"],
      labels: List<StoryLabel>.from(
          json["labels"].map((e) => StoryLabel.fromJson(e))),
    );
  }
}

class StoryLabel {
  String name;

  StoryLabel({required this.name});

  factory StoryLabel.fromJson(Map<String, dynamic> json) {
    return StoryLabel(name: json["name"]);
  }
}
