import 'package:chain_deeds_app/core/utils/progress_dialog_utils.dart';
import 'package:chain_deeds_app/model/blog_model/blog_category_model.dart';
import 'package:chain_deeds_app/repository/blog_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/blog_model/blog_model.dart';
import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService _homeService = BlogService();
  BlogModel? blogModel;
  BlogCategoryModel? blogCategoryModel;
  BlogBloc() : super(BlogInitial()) {
    on<BlogDataEvent>(_getBlogData);
    on<AddBlogEvent>(_addBlog);
    on<BlogCategoryEvent>(_getBlogCategoryData);
  }

  _getBlogData(BlogDataEvent event, Emitter<BlogState> emit) async {
    emit(BlogInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(BlogLoading());
    try {
      blogModel = await _homeService.getBlogData();
      // ProgressDialogUtils.hideProgressDialog();

      if (blogModel?.status ?? false) {
        emit(BlogSuccess({}));
      }
    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(BlogFailure("Data Get failed: ${e.toString()}"));
    }
  }

  _getBlogCategoryData(BlogCategoryEvent event, Emitter<BlogState> emit) async {
    emit(BlogInitial());
    // ProgressDialogUtils.showProgressDialog();
    emit(BlogLoading());
    try {
      blogCategoryModel = await _homeService.getCategoryBlogData();
      // ProgressDialogUtils.hideProgressDialog();

        emit(BlogSuccess({}));

    } catch (e) {
      // ProgressDialogUtils.hideProgressDialog();
      emit(BlogFailure("Data Get failed: ${e.toString()}"));
    }
  }

  _addBlog(AddBlogEvent event, Emitter<BlogState> emit) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      print(event.categoryId);
      print(event.thumbnail);
      print(event.title);
      print(event.sub_title);
      print(event.description);
       Map<String ,dynamic> response = await _homeService.addBlogData(event.categoryId, event.thumbnail, event.title, event.sub_title, event.description);
      ProgressDialogUtils.hideProgressDialog();
      // ProgressDialogUtils.hideProgressDialog();
       print(response);
      emit(BlogSuccess(response));
    } catch (e) {
      ProgressDialogUtils.hideProgressDialog();
      emit(BlogFailure("Data Get failed: ${e.toString()}"));
    }
  }
}
