import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

import 'disaster_type.dart';

class DisasterPost {
  String postId;
  String photoUrl;
  Position position;
  String? description;
  DisasterType disasterType;
  DisasterMedia media;
  int time = DateTime.now().millisecondsSinceEpoch;
  DisasterPost({
    required this.postId,
    required this.photoUrl,
    required this.position,
    this.description,
    required this.disasterType,
    required this.media,
    required this.time,
  });

  DisasterPost copyWith({
    String? postId,
    String? photoUrl,
    Position? position,
    String? description,
    DisasterType? disasterType,
    DisasterMedia? media,
    int? time,
  }) {
    return DisasterPost(
      postId: postId ?? this.postId,
      photoUrl: photoUrl ?? this.photoUrl,
      position: position ?? this.position,
      description: description ?? this.description,
      disasterType: disasterType ?? this.disasterType,
      media: media ?? this.media,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'postId': postId});
    result.addAll({'photoUrl': photoUrl});
    result.addAll({'position': position.toMap()});
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'disasterType': disasterType.toMap()});
    result.addAll({'media': media.toMap()});
    result.addAll({'time': time});

    return result;
  }

  factory DisasterPost.fromMap(Map<String, dynamic> map) {
    return DisasterPost(
      postId: map['postId'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      position: Position.fromMap(map['position'] ?? {}),
      description: map['description'],
      disasterType: DisasterType.fromMap(map['disasterType']),
      media: DisasterMedia.fromMap(map['media'] ?? {}),
      time: map['time']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisasterPost.fromJson(String source) =>
      DisasterPost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisasterPost(postId: $postId, photoUrl: $photoUrl, position: $position, description: $description, disasterType: $disasterType, media: $media, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisasterPost &&
        other.postId == postId &&
        other.photoUrl == photoUrl &&
        other.position == position &&
        other.description == description &&
        other.disasterType == disasterType &&
        other.media == media &&
        other.time == time;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        photoUrl.hashCode ^
        position.hashCode ^
        description.hashCode ^
        disasterType.hashCode ^
        media.hashCode ^
        time.hashCode;
  }
}

class DisasterMedia {
  MediaFile? image;
  MediaFile? video;
  MediaFile? audio;
  DisasterMedia({required this.image, this.video, this.audio});

  factory DisasterMedia.fromMap(Map<String, dynamic> map) => DisasterMedia(
        image: map['image'] == null ? null : MediaFile.fromMap(map['image']),
        video: map['video'] == null ? null : MediaFile.fromMap(map['video']),
        audio: map['audio'] == null ? null : MediaFile.fromMap(map['audio']),
      );

  Map<String, dynamic> toMap() => {
        "image": image?.toMap(),
        "video": video?.toMap(),
        "audio": audio?.toMap(),
      };
}

class MediaFile {
  File? file;
  String? url;
  FileType type;

  MediaFile({this.file, this.url, required this.type});
  factory MediaFile.fromMap(Map<String, dynamic> map) =>
      MediaFile(url: map['url'], type: FileType.values[map['fileType']]);

  Map<String, dynamic> toMap() => {"fileType": type.index, "url": url};
}

extension on Position {
  Map<String, dynamic> toMap() => {"lat": latitude, "lon": longitude};
}

enum FileType { image, video, record }
