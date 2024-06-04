class User {
  final String id;
  final String name;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  User.fromUser(User user)
      : id = user.id,
        name = user.name,
        avatarUrl = user.avatarUrl;

  User.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        avatarUrl = map['avatarUrl'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatarUrl': avatarUrl,
      };
}
