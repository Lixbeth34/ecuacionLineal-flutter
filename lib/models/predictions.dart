class Predictions {
  
  List predictions;

  Predictions(
    {
      required this.predictions,
    });
  
  factory Predictions.fromJson(Map json){
    return Predictions(
      predictions: json["predictions"]
    );
  }
}