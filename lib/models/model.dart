class BimMeasure {
  int? id;
  double weight; // in kg
  double height; // in cm
  double bim;
  String category;
  DateTime date;

  static final comlumns = ['id', 'weight', 'height', 'bim', 'category', 'date'];
  static final String tabbleName = "Bim";
  BimMeasure(
      {this.id,
      required this.weight,
      required this.height,
      required this.bim,
      required this.category,
      required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "weight": weight,
      "height": height,
      "bim": bim,
      "category": category,
      "date": date.toString()
    };
  }

  String toString() {
    return 'ID = $id Taille : $height  Poids : $weight  IMC: $bim Category: $category Date : $date';
  }
}
