class TrendyColorModel {
  final String colorName;
  final String tcxCode;
  final int cardColorR;
  final int cardColorG;
  final int cardColorB;
  final int fontColorR;
  final int fontColorG;
  final int fontColorB;

  TrendyColorModel({
    required this.colorName,
    required this.tcxCode,
    required this.cardColorR,
    required this.cardColorG,
    required this.cardColorB,
    required this.fontColorR,
    required this.fontColorG,
    required this.fontColorB,
  });

  Map<String, dynamic> toMap() {
    return {
      'colorName': colorName,
      'tcxCode': tcxCode,
      'cardColorR': cardColorR,
      'cardColorG': cardColorG,
      'cardColorB': cardColorB,
      'fontColorR': fontColorR,
      'fontColorG': fontColorG,
      'fontColorB': fontColorB,
    };
  }

  factory TrendyColorModel.fromMap(Map<String, dynamic> map) {
    return TrendyColorModel(
      colorName: map['colorName'],
      tcxCode: map['tcxCode'],
      cardColorR: map['cardColorR'],
      cardColorG: map['cardColorG'],
      cardColorB: map['cardColorB'],
      fontColorR: map['fontColorR'],
      fontColorG: map['fontColorG'],
      fontColorB: map['fontColorB'],
    );
  }
}
