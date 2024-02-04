class topicModel {
  final int? id;
  final String title;
  final String conversation;

  topicModel({this.id, required this.title, required this.conversation});

  topicModel.formMap(Map<String, dynamic> item):
    id = item['id'],
    title = item['title'],
    conversation = item['conversation'];
  Map<String, dynamic> toMap() {
    return { 'id': id, 'title': title, 'conversation': conversation };
  }
}