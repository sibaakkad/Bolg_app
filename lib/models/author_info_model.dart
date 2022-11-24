import 'dart:convert';

AuthorInfoModel authorInfoModelFromJson(String str) =>
    AuthorInfoModel.fromJson(json.decode(str));

String authorInfoModelToJson(AuthorInfoModel data) =>
    json.encode(data.toJson());

class AuthorInfoModel {
  AuthorInfoModel({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.meta,
  });

  int? id;
  String? name;
  String? url;
  String? description;
  String? link;
  String? slug;
  Meta? meta;

  factory AuthorInfoModel.fromJson(Map<String, dynamic> json) =>
      AuthorInfoModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        slug: json["slug"],
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "link": link,
        "slug": slug,
        "meta": meta!.toJson(),
      };
}

class Meta {
  Meta({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.followersCount,
    this.followers,
    this.followingCount,
    this.followings,
    this.country,
    this.points,
    this.employmentStatus,
    this.gender,
    this.birthDate,
    this.jobTitle,
    this.company,
    this.educationalLevel,
    this.skills,
    this.favCategories,
    this.interestedLearning,
    this.languages,
    this.favorite,
    this.readLater,
    this.showField,
    this.facebookLink,
    this.twitterLink,
    this.instagramLink,
    this.linkedinLink,
    this.youtubeLink,
    this.newsletterSettings,
    this.userLvl,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? avatar;
  int? followersCount;
  List<int>? followers;
  int? followingCount;
  List<dynamic>? followings;
  String? country;
  String? points;
  String? employmentStatus;
  String? gender;
  String? birthDate;
  String? jobTitle;
  String? company;
  String? educationalLevel;
  List<dynamic>? skills;
  FavCategories? favCategories;
  FavCategories? interestedLearning;
  List<dynamic>? languages;
  List<dynamic>? favorite;
  List<dynamic>? readLater;
  List<dynamic>? showField;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? linkedinLink;
  String? youtubeLink;
  NewsletterSettings? newsletterSettings;
  String? userLvl;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        avatar: json["avatar"],
        followersCount: json["followers_count"],
        followers: List<int>.from(json["followers"].map((x) => x)),
        followingCount: json["following_count"],
        followings: List<dynamic>.from(json["followings"].map((x) => x)),
        country: json["country"],
        points: json["points"],
        employmentStatus: json["employment_status"],
        gender: json["gender"],
        birthDate: json["birth_date"],
        jobTitle: json["job_title"],
        company: json["company"],
        educationalLevel: json["educational_level"],
        skills: List<dynamic>.from(json["skills"].map((x) => x)),
        favCategories: FavCategories.fromJson(json["fav_categories"]),
        interestedLearning: FavCategories.fromJson(json["interested_learning"]),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
        favorite: List<dynamic>.from(json["favorite"].map((x) => x)),
        readLater: List<dynamic>.from(json["read_later"].map((x) => x)),
        showField: List<dynamic>.from(json["show_field"].map((x) => x)),
        facebookLink: json["facebook_link"],
        twitterLink: json["twitter_link"],
        instagramLink: json["instagram_link"],
        linkedinLink: json["linkedin_link"],
        youtubeLink: json["youtube_link"],
        newsletterSettings:
            NewsletterSettings.fromJson(json["newsletter_settings"]),
        userLvl: json["user_lvl"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "avatar": avatar,
        "followers_count": followersCount,
        "followers": List<dynamic>.from(followers!.map((x) => x)),
        "following_count": followingCount,
        "followings": List<dynamic>.from(followings!.map((x) => x)),
        "country": country,
        "points": points,
        "employment_status": employmentStatus,
        "gender": gender,
        "birth_date": birthDate,
        "job_title": jobTitle,
        "company": company,
        "educational_level": educationalLevel,
        "skills": List<dynamic>.from(skills!.map((x) => x)),
        "fav_categories": favCategories!.toJson(),
        "interested_learning": interestedLearning!.toJson(),
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "favorite": List<dynamic>.from(favorite!.map((x) => x)),
        "read_later": List<dynamic>.from(readLater!.map((x) => x)),
        "show_field": List<dynamic>.from(showField!.map((x) => x)),
        "facebook_link": facebookLink,
        "twitter_link": twitterLink,
        "instagram_link": instagramLink,
        "linkedin_link": linkedinLink,
        "youtube_link": youtubeLink,
        "newsletter_settings": newsletterSettings!.toJson(),
        "user_lvl": userLvl,
      };
}

class FavCategories {
  FavCategories();

  factory FavCategories.fromJson(Map<String, dynamic> json) => FavCategories();

  Map<String, dynamic> toJson() => {};
}

class NewsletterSettings {
  NewsletterSettings({
    this.repeat,
    this.categories,
    this.notification,
  });

  String? repeat;
  List<String>? categories;
  List<dynamic>? notification;

  factory NewsletterSettings.fromJson(Map<String, dynamic> json) =>
      NewsletterSettings(
        repeat: json["repeat"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        notification: List<dynamic>.from(json["notification"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "repeat": repeat,
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "notification": List<dynamic>.from(notification!.map((x) => x)),
      };
}
