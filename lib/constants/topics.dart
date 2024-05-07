class TopicItem {
  final name;
  final uid;

  const TopicItem({required this.name, required this.uid});
}

const topicsConstant = <TopicItem>[
  TopicItem(name: "درس خواندن", uid: "study"),
  TopicItem(name: "بازی ویدیویی", uid: "game"),
  TopicItem(name: "کار", uid: "work"),
];