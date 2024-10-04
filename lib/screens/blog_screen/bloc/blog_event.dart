import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class BlogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BlogDataEvent extends BlogEvent {

  BlogDataEvent();
  @override
  List<Object> get props => [];
}
class AddBlogEvent extends BlogEvent {
  String categoryId;
      String thumbnail;
  String title;
      String sub_title;
  String description;
  AddBlogEvent(this.categoryId,this.thumbnail,this.title,this.sub_title,this.description);
  @override
  List<Object> get props => [categoryId,thumbnail,title,sub_title,description];
}
class BlogCategoryEvent extends BlogEvent {
  BlogCategoryEvent();
  @override
  List<Object> get props => [];
}


