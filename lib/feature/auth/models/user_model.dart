// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String email;
  String userId;
  String? image;
  String? userName;
  String? displayName;
  String? name;
  String? bio;
  String? date;
  String? gender;
  String? address;
  String? country;
  String? city;
  String? zipCode;
  String? chasingCategory;
  String? chasingDescription;
  UserModel({
    required this.email,
    required this.userId,
    this.image,
    this.userName,
    this.displayName,
    this.name,
    this.bio,
    this.date,
    this.gender,
    this.address,
    this.country,
    this.city,
    this.zipCode,
    this.chasingCategory,
    this.chasingDescription,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'userId': userId,
      'image': image,
      'userName': userName,
      'displayName': displayName,
      'name': name,
      'bio': bio,
      'date': date,
      'gender': gender,
      'address': address,
      'country': country,
      'city': city,
      'zipCode': zipCode,
      'chasingCategory': chasingCategory,
      'chasingDescription': chasingDescription,
    };
  }

  Map<String, dynamic> toMapCompleteProfile() {
    return <String, dynamic>{
      'image': image,
      'userName': userName,
      'displayName': displayName,
      'name': name,
      'bio': bio,
      'date': date,
      'gender': gender,
      'address': address,
      'country': country,
      'city': city,
      'zipCode': zipCode,
      'chasingCategory': chasingCategory,
      'chasingDescription': chasingDescription,
    };
  }

  Map<String, dynamic> toMapPost() {
    return <String, dynamic>{
      'image': image,
      'userName': userName,
      'userId': userId
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      userId: map['userId'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      zipCode: map['zipCode'] != null ? map['zipCode'] as String : null,
      chasingCategory: map['chasingCategory'] != null
          ? map['chasingCategory'] as String
          : null,
      chasingDescription: map['chasingDescription'] != null
          ? map['chasingDescription'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? email,
    String? userId,
    String? image,
    String? userName,
    String? displayName,
    String? name,
    String? bio,
    String? date,
    String? gender,
    String? address,
    String? country,
    String? city,
    String? zipCode,
    String? chasingCategory,
    String? chasingDescription,
  }) {
    return UserModel(
      email: email ?? this.email,
      userId: userId ?? this.userId,
      image: image ?? this.image,
      userName: userName ?? this.userName,
      displayName: displayName ?? this.displayName,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      date: date ?? this.date,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      country: country ?? this.country,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      chasingCategory: chasingCategory ?? this.chasingCategory,
      chasingDescription: chasingDescription ?? this.chasingDescription,
    );
  }
}
