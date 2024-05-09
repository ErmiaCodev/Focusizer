class TopicItem {
  final name;
  final uid;

  const TopicItem({required this.name, required this.uid});
}

const topicsMap = {
  'game': 'بازی ویدیویی',
  'study': 'درس خواندن',
  'work': 'کار',
  'nan': '',
};

const topicsConstant = <TopicItem>[
  TopicItem(name: "درس خواندن", uid: "study"),
  TopicItem(name: "بازی ویدیویی", uid: "game"),
  TopicItem(name: "کار", uid: "work"),
];