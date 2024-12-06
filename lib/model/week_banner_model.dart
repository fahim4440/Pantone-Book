class WeekBannerModel {
  final String colorName;
  final String tcxCode;
  final int tcxColorR;
  final int tcxColorG;
  final int tcxColorB;
  final int bannerColorR;
  final int bannerColorG;
  final int bannerColorB;
  final int bannerFontColorR;
  final int bannerFontColorG;
  final int bannerFontColorB;
  final int tcxFontColorR;
  final int tcxFontColorG;
  final int tcxFontColorB;

  WeekBannerModel({
    required this.colorName,
    required this.tcxCode,
    required this.tcxColorR,
    required this.tcxColorG,
    required this.tcxColorB,
    required this.bannerColorR,
    required this.bannerColorG,
    required this.bannerColorB,
    required this.bannerFontColorR,
    required this.bannerFontColorG,
    required this.bannerFontColorB,
    required this.tcxFontColorR,
    required this.tcxFontColorG,
    required this.tcxFontColorB,
  });

  // Convert a WeekBannerModel into a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'colorName': colorName,
      'tcxCode': tcxCode,
      'tcxColorR': tcxColorR,
      'tcxColorG': tcxColorG,
      'tcxColorB': tcxColorB,
      'bannerColorR': bannerColorR,
      'bannerColorG': bannerColorG,
      'bannerColorB': bannerColorB,
      'bannerFontColorR': bannerFontColorR,
      'bannerFontColorG': bannerFontColorG,
      'bannerFontColorB': bannerFontColorB,
      'tcxFontColorR': tcxFontColorR,
      'tcxFontColorG': tcxFontColorG,
      'tcxFontColorB': tcxFontColorB,
    };
  }

  // A method that converts a map into a WeekBannerModel instance
  factory WeekBannerModel.fromMap(Map<String, dynamic> map) {
    return WeekBannerModel(
      colorName: map['colorName'],
      tcxCode: map['tcxCode'],
      tcxColorR: map['tcxColorR'],
      tcxColorG: map['tcxColorG'],
      tcxColorB: map['tcxColorB'],
      bannerColorR: map['bannerColorR'],
      bannerColorG: map['bannerColorG'],
      bannerColorB: map['bannerColorB'],
      bannerFontColorR: map['bannerFontColorR'],
      bannerFontColorG: map['bannerFontColorG'],
      bannerFontColorB: map['bannerFontColorB'],
      tcxFontColorR: map['tcxFontColorR'],
      tcxFontColorG: map['tcxFontColorG'],
      tcxFontColorB: map['tcxFontColorB'],
    );
  }
}
