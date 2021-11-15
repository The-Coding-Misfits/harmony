class CustomException implements Exception {
  String cause;
  CustomException(this.cause);

  @override
  String toString(){
    return cause;
  }
}