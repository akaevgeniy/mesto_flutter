class ResponseModel {
  bool success;
  Map<String, dynamic>? error;

  ResponseModel({
    required this.success,
    this.error,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json["success"] as bool,
        error: json["error"],
      );
}
