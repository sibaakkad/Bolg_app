
import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
    PostModel({
        this.id,
        this.date,
        this.dateGmt,
        this.type,
        this.link,
        this.title,
        this.content,
        this.author,
        this.featuredMedia,
        this.sticky,
        this.template,
        this.format,
        this.meta,
        this.categories,
        this.tags,
        this.embedded,
    });

    final int? id;
    final DateTime? date;
    final DateTime? dateGmt;
    final String? type;
    final String? link;
    final Title? title;
    final Content? content;
    final PostModelAuthor? author;
    final int? featuredMedia;
    final bool? sticky;
    final String? template;
    final String? format;
    final Meta ?meta;
    final List<int>? categories;
    final List<dynamic>? tags;
    final Embedded ?embedded;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dateGmt: json["date_gmt"] == null ? null : DateTime.parse(json["date_gmt"]),
        type: json["type"] == null ? null : json["type"],
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : Title.fromJson(json["title"]),
        content: json["content"] == null ? null : Content.fromJson(json["content"]),
        //author: json["author"] == null ? null : PostModelAuthor.fromJson(json["author"]),
        featuredMedia: json["featured_media"] == null ? null : json["featured_media"],
        sticky: json["sticky"] == null ? null : json["sticky"],
        template: json["template"] == null ? null : json["template"],
        format: json["format"] == null ? null : json["format"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        categories: json["categories"] == null ? null : List<int>.from(json["categories"].map((x) => x)),
        tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
        embedded: json["_embedded"] == null ? null : Embedded.fromJson(json["_embedded"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date!.toIso8601String(),
        "date_gmt": dateGmt == null ? null : dateGmt!.toIso8601String(),
        "type": type == null ? null : type,
        "link": link == null ? null : link,
        "title": title == null ? null : title!.toJson(),
        "content": content == null ? null : content!.toJson(),
        "author": author == null ? null : author!.toJson(),
        "featured_media": featuredMedia == null ? null : featuredMedia,
        "sticky": sticky == null ? null : sticky,
        "template": template == null ? null : template,
        "format": format == null ? null : format,
        "meta": meta == null ? null : meta!.toJson(),
        "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x)),
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "_embedded": embedded == null ? null : embedded!.toJson(),
    };
}

class PostModelAuthor {
    PostModelAuthor({
        this.id,
        this.fullname,
        this.link,
        this.avatar,
    });

    final int? id;
    final String? fullname;
    final String? link;
    final String? avatar;

    factory PostModelAuthor.fromJson(Map<String, dynamic> json) => PostModelAuthor(
        id: json["id"] == null ? null : json["id"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        link: json["link"] == null ? null : json["link"],
        avatar: json["avatar"] == null ? null : json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fullname": fullname == null ? null : fullname,
        "link": link == null ? null : link,
        "avatar": avatar == null ? null : avatar,
    };
}

class Content {
    Content({
        this.rendered,
        this.protected,
    });

    final String? rendered;
    final bool ?protected;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"] == null ? null : json["rendered"],
        protected: json["protected"] == null ? null : json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered == null ? null : rendered,
        "protected": protected == null ? null : protected,
    };
}

class Embedded {
    Embedded({
        this.author,
        this.wpFeaturedmedia,
        this.wpTerm,
    });

    final List<AuthorElement>? author;
    final List<WpFeaturedmedia>? wpFeaturedmedia;
    final List<List<WpTerm>>? wpTerm;

    factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        author: json["author"] == null ? null : List<AuthorElement>.from(json["author"].map((x) => AuthorElement.fromJson(x))),
        wpFeaturedmedia: json["wp:featuredmedia"] == null ? null : List<WpFeaturedmedia>.from(json["wp:featuredmedia"].map((x) => WpFeaturedmedia.fromJson(x))),
        wpTerm: json["wp:term"] == null ? null : List<List<WpTerm>>.from(json["wp:term"].map((x) => List<WpTerm>.from(x.map((x) => WpTerm.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "author": author == null ? null : List<dynamic>.from(author!.map((x) => x.toJson())),
        "wp:featuredmedia": wpFeaturedmedia == null ? null : List<dynamic>.from(wpFeaturedmedia!.map((x) => x.toJson())),
        "wp:term": wpTerm == null ? null : List<dynamic>.from(wpTerm!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    };
}

class AuthorElement {
    AuthorElement({
        this.id,
        this.name,
        this.url,
        this.description,
        this.link,
        this.slug,
        this.avatarUrls,
        this.links,
    });

    final int? id;
    final String? name;
    final String? url;
    final String? description;
    final String? link;
    final String? slug;
    final Map<String, String>? avatarUrls;
    final Links? links;

    factory AuthorElement.fromJson(Map<String, dynamic> json) => AuthorElement(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        slug: json["slug"] == null ? null : json["slug"],
        avatarUrls: json["avatar_urls"] == null ? null : Map.from(json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "slug": slug == null ? null : slug,
        "avatar_urls": avatarUrls == null ? null : Map.from(avatarUrls!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_links": links == null ? null : links!.toJson(),
    };
}

class Links {
    Links({
        this.self,
        this.collection,
    });

    final List<Collection>? self;
    final List<Collection>? collection;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? null : List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
        collection: json["collection"] == null ? null : List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? null : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null ? null : List<dynamic>.from(collection!.map((x) => x.toJson())),
    };
}

class Collection {
    Collection({
        this.href,
    });

    final String? href;

    factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"] == null ? null : json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href == null ? null : href,
    };
}

class WpFeaturedmedia {
    WpFeaturedmedia({
        this.id,
        this.date,
        this.slug,
        this.type,
        this.link,
        this.title,
        this.author,
        this.caption,
        this.altText,
        this.mediaType,
        this.mimeType,
        this.mediaDetails,
        this.sourceUrl,
    });

    final int? id;
    final DateTime? date;
    final String? slug;
    final String? type;
    final String? link;
    final Title? title;
    final int? author;
    final Title? caption;
    final String? altText;
    final String? mediaType;
    final MimeType? mimeType;
    final MediaDetails? mediaDetails;
    final String? sourceUrl;

    factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) => WpFeaturedmedia(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        slug: json["slug"] == null ? null : json["slug"],
        type: json["type"] == null ? null : json["type"],
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : Title.fromJson(json["title"]),
        author: json["author"] == null ? null : json["author"],
        caption: json["caption"] == null ? null : Title.fromJson(json["caption"]),
        altText: json["alt_text"] == null ? null : json["alt_text"],
        mediaType: json["media_type"] == null ? null : json["media_type"],
        mimeType: json["mime_type"] == null ? null : mimeTypeValues.map![json["mime_type"]],
        mediaDetails: json["media_details"] == null ? null : MediaDetails.fromJson(json["media_details"]),
        sourceUrl: json["source_url"] == null ? null : json["source_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date!.toIso8601String(),
        "slug": slug == null ? null : slug,
        "type": type == null ? null : type,
        "link": link == null ? null : link,
        "title": title == null ? null : title!.toJson(),
        "author": author == null ? null : author,
        "caption": caption == null ? null : caption!.toJson(),
        "alt_text": altText == null ? null : altText,
        "media_type": mediaType == null ? null : mediaType,
        "mime_type": mimeType == null ? null : mimeTypeValues.reverse![mimeType],
        "media_details": mediaDetails == null ? null : mediaDetails!.toJson(),
        "source_url": sourceUrl == null ? null : sourceUrl,
    };
}

class Title {
    Title({
        this.rendered,
    });

    final String? rendered;

    factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"] == null ? null : json["rendered"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered == null ? null : rendered,
    };
}

class MediaDetails {
    MediaDetails({
        this.width,
        this.height,
        this.file,
        this.sizes,
    });

    final int? width;
    final int? height;
    final String? file;
    final Sizes? sizes;

    factory MediaDetails.fromJson(Map<String, dynamic> json) => MediaDetails(
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        file: json["file"] == null ? null : json["file"],
        sizes: json["sizes"] == null ? null : Sizes.fromJson(json["sizes"]),
    );

    Map<String, dynamic> toJson() => {
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "file": file == null ? null : file,
        "sizes": sizes == null ? null : sizes!.toJson(),
    };
}

class Sizes {
    Sizes({
        this.thumbnail,
        this.smallSticky,
        this.singlePost,
        this.singleBook,
        this.sidePost,
        this.sideBook,
        this.cardPost,
        this.cardBook,
        this.slideBook,
        this.full,
    });

    final CardBook? thumbnail;
    final CardBook? smallSticky;
    final CardBook? singlePost;
    final CardBook? singleBook;
    final CardBook? sidePost;
    final CardBook? sideBook;
    final CardBook? cardPost;
    final CardBook? cardBook;
    final CardBook? slideBook;
    final CardBook? full;

    factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        thumbnail: json["thumbnail"] == null ? null : CardBook.fromJson(json["thumbnail"]),
        smallSticky: json["small-sticky"] == null ? null : CardBook.fromJson(json["small-sticky"]),
        singlePost: json["single-post"] == null ? null : CardBook.fromJson(json["single-post"]),
        singleBook: json["single-book"] == null ? null : CardBook.fromJson(json["single-book"]),
        sidePost: json["side-post"] == null ? null : CardBook.fromJson(json["side-post"]),
        sideBook: json["side-book"] == null ? null : CardBook.fromJson(json["side-book"]),
        cardPost: json["card-post"] == null ? null : CardBook.fromJson(json["card-post"]),
        cardBook: json["card-book"] == null ? null : CardBook.fromJson(json["card-book"]),
        slideBook: json["slide-book"] == null ? null : CardBook.fromJson(json["slide-book"]),
        full: json["full"] == null ? null : CardBook.fromJson(json["full"]),
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail == null ? null : thumbnail!.toJson(),
        "small-sticky": smallSticky == null ? null : smallSticky!.toJson(),
        "single-post": singlePost == null ? null : singlePost!.toJson(),
        "single-book": singleBook == null ? null : singleBook!.toJson(),
        "side-post": sidePost == null ? null : sidePost!.toJson(),
        "side-book": sideBook == null ? null : sideBook!.toJson(),
        "card-post": cardPost == null ? null : cardPost!.toJson(),
        "card-book": cardBook == null ? null : cardBook!.toJson(),
        "slide-book": slideBook == null ? null : slideBook!.toJson(),
        "full": full == null ? null : full!.toJson(),
    };
}

class CardBook {
    CardBook({
        this.file,
        this.width,
        this.height,
        this.mimeType,
        this.sourceUrl,
    });

    final String? file;
    final int? width;
    final int ?height;
    final MimeType? mimeType;
    final String ?sourceUrl;

    factory CardBook.fromJson(Map<String, dynamic> json) => CardBook(
        file: json["file"] == null ? null : json["file"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        mimeType: json["mime_type"] == null ? null : mimeTypeValues.map![json["mime_type"]],
        sourceUrl: json["source_url"] == null ? null : json["source_url"],
    );

    Map<String, dynamic> toJson() => {
        "file": file == null ? null : file,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "mime_type": mimeType == null ? null : mimeTypeValues.reverse![mimeType],
        "source_url": sourceUrl == null ? null : sourceUrl,
    };
}

enum MimeType { IMAGE_JPEG }

final mimeTypeValues = EnumValues({
    "image/jpeg": MimeType.IMAGE_JPEG
});

class WpTerm {
    WpTerm({
        this.id,
        this.link,
        this.name,
        this.slug,
        this.taxonomy,
    });

    final int? id;
    final String? link;
    final String? name;
    final String? slug;
    final String? taxonomy;

    factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
        id: json["id"] == null ? null : json["id"],
        link: json["link"] == null ? null : json["link"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        taxonomy: json["taxonomy"] == null ? null : json["taxonomy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "link": link == null ? null : link,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "taxonomy": taxonomy == null ? null : taxonomy,
    };
}

class Meta {
    Meta({
        this.postViewsCount,
        this.readTime,
        this.readersCount,
        this.readers,
        this.clapCount,
    });

    final String? postViewsCount;
    final String? readTime;
    final String? readersCount;
    final List<String>? readers;
    final String? clapCount;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        postViewsCount: json["post_views_count"] == null ? null : json["post_views_count"],
        readTime: json["read_time"] == null ? null : json["read_time"],
        readersCount: json["readers_count"] == null ? null : json["readers_count"],
        readers: json["readers"] == null ? null : List<String>.from(json["readers"].map((x) => x)),
        clapCount: json["clap_count"] == null ? null : json["clap_count"],
    );

    Map<String, dynamic> toJson() => {
        "post_views_count": postViewsCount == null ? null : postViewsCount,
        "read_time": readTime == null ? null : readTime,
        "readers_count": readersCount == null ? null : readersCount,
        "readers": readers == null ? null : List<dynamic>.from(readers!.map((x) => x)),
        "clap_count": clapCount == null ? null : clapCount,
    };
}

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
