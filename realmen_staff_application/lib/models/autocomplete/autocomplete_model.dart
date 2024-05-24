class PredictionModel {
  String? description;
  String? placeId;

  PredictionModel({this.description, this.placeId});
  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      description: json['description'],
      placeId: json['placeId'],
    );
  }
}

class AutocompleteModel {
  List<PredictionModel>? predictions;

  AutocompleteModel({this.predictions});

  factory AutocompleteModel.fromJson(Map<String, dynamic> json) {
    return AutocompleteModel(
        predictions: List<PredictionModel>.from(json['value']['predictions']
            .map((e) => PredictionModel.fromJson(e))));
  }
}
