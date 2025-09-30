abstract class ApiConcumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameter});
}
