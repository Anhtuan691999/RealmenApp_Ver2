class ServerExceptionModel {
  ServerExceptionModel({this.message, this.description});

  String? message;
  String? description;

  factory ServerExceptionModel.fromJson(Map<String, dynamic> json) =>
      ServerExceptionModel(
          message: json["message"], description: json["description"]);
}
