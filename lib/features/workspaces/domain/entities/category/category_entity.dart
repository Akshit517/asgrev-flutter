import '../channel/channel_entity.dart';

class Category {
  final int id;
  final String name;
  final String workspace;
  final List<Channel> channels;

  const Category({
    required this.id,
    required this.name,
    required this.workspace,
    required this.channels,
  });
}
