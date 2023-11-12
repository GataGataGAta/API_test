class User {
  // コンストラクタ
  User({
    required this.id,
    required this.profileImageUrl,
  });

  // プロパティ
  final String id;
  final String profileImageUrl;
  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] as String,
      profileImageUrl: json['profile_image_url'] as String,
    );
  }
}
