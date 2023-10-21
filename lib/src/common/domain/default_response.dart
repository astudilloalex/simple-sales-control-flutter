class DefaultResponse {
  const DefaultResponse({
    this.statusCode = 200,
    this.message = 'successful',
    this.data,
  });

  final int statusCode;
  final String message;
  final dynamic data;
}
