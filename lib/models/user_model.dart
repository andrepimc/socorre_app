import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String? tel;
  final String? username;
  final String? avatar_url;
  UserModel({
    this.id = '',
    this.email = '',
    this.tel,
    this.username,
    this.avatar_url,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? tel,
    String? username,
    String? avatar_url,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      tel: tel ?? this.tel,
      username: username ?? this.username,
      avatar_url: avatar_url ?? this.avatar_url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'email': email});
    if (tel != null) {
      result.addAll({'tel': tel});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (avatar_url != null) {
      result.addAll({'avatar_url': avatar_url});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      tel: map['tel'],
      username: map['username'],
      avatar_url: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, tel: $tel, username: $username, avatar_url: $avatar_url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.tel == tel &&
        other.username == username &&
        other.avatar_url == avatar_url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        tel.hashCode ^
        username.hashCode ^
        avatar_url.hashCode;
  }
}
