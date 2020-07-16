part of 'create_case_bloc.dart';

@immutable
class CreateCaseState {
  final String title;
  final String detail;
  final List<String> tags;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  CreateCaseState({
    @required this.title,
    @required this.detail,
    @required this.tags,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory CreateCaseState.empty() {
    return CreateCaseState(
      title: '',
      detail: '',
      tags: [],
      isSubmitting: false,
      isSuccess: null,
      isFailure: null,
    );
  }

  CreateCaseState updateTitle({@required String newTitle}) {
    return _copyWith(title: newTitle);
  }

  CreateCaseState updateDetail({@required String newDetail}) {
    return _copyWith(detail: newDetail);
  }

  CreateCaseState addTag({@required String tagLabel}) {
    return _copyWith(tags: this.tags..add(tagLabel));
  }

  CreateCaseState removeTag({@required int index}) {
    return _copyWith(tags: this.tags..removeAt(index));
  }

  CreateCaseState submit() {
    return _copyWith(isSubmitting: true);
  }

  CreateCaseState success() {
    return _copyWith(isSubmitting: false, isSuccess: true);
  }

  CreateCaseState failure() {
    return _copyWith(isSubmitting: false, isFailure: true);
  }

  CreateCaseState _copyWith({
    String title,
    String detail,
    List<String> tags,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return CreateCaseState(
      title: title ?? this.title,
      detail: detail ?? this.detail,
      tags: tags ?? this.tags,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
    );
  }

  @override
  String toString() {
    return '''CreateCaseState {
      'title': $title,
      'detail': $detail,
      'tags': $tags,
      'isSubmitting': $isSubmitting,
      'isSuccess': $isSuccess,
      'isFailure': $isFailure,
    }''';
  }
}
