
import 'my_blog_model.dart';

class Message {
  final int id;
  final String message;
  final String createdAt;
   int likes;
   int unlikes;
  bool isLiked;
  bool isDisliked;

  Message({required this.id, required this.message, required this.createdAt, required this.likes, required this.unlikes,this.isLiked = false,
    this.isDisliked = false,});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      createdAt: json['created_at'],
      likes: json['likes'],
      unlikes: json['unlikes'],
    );
  }
  // Method to convert a Message object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'created_at': createdAt,
      'likes': likes,
      'unlikes': unlikes,
    };
  }
}

class Messages {
  final Map<String, List<Message>> messages;

  Messages({required this.messages});

  // Updated fromJson to handle both empty lists and maps
  factory Messages.fromJson(dynamic json) {
    // Initialize an empty map if messages is empty
    final Map<String, List<Message>> parsedMessages = {};

    // Check if json is an empty list or a map
    if (json is List && json.isEmpty) {
      // If it's an empty list, just return an empty map
      return Messages(messages: parsedMessages);
    } else if (json is Map<String, dynamic>) {
      // If it's a map, proceed with parsing the messages
      json.forEach((key, value) {
        if (value is List) {
          parsedMessages[key] = value.map((messageJson) {
            return Message.fromJson(messageJson as Map<String, dynamic>);
          }).toList();
        }
      });
      return Messages(messages: parsedMessages);
    } else {
      throw Exception('Unexpected type for messages: ${json.runtimeType}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    messages.forEach((key, value) {
      json[key] = value.map((message) => message.toJson()).toList();
    });
    return json;
  }
}


class Data {
  List<MyBlogModel>? blogs;
   Messages? messages;

  Data({required this.blogs, required this.messages});

  // Factory constructor to create an instance from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      blogs: (json['blogs'] as List)
          .map((blog) => MyBlogModel.fromJson(blog))
          .toList(),
      messages:json['messages'] !=[] ?  Messages.fromJson(json['messages']):Messages(messages: {}),
    );
  }

}

class MemberMessageModel {
  final Data data;
  final String message;
  final bool status;

  MemberMessageModel({required this.data, required this.message, required this.status});

  factory MemberMessageModel.fromJson(Map<String, dynamic> json) {
    return MemberMessageModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      status: json['status'],
    );
  }
}
