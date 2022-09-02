class ResultItem<T> {

  String message;
  int? errorCode;
  T result;

  ResultItem({required this.result, this.message = '', this.errorCode});

}