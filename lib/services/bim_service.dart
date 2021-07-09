class BimService {
  final List<String> corpulences = [
    'Insuffisance pondérale (maigreur)',
    'Corpulence normale',
    'Surpoids',
    'Obésité modérée',
    'Obésité sévère',
    'Obésité morbide(massive)'
  ];

  double computeBim(double weight, double height) {
    return weight / (height * height);
  }

  int category(double bim) {
    if (bim <= 18.5) {
      return 0;
    }
    if (18.5 < bim && bim <= 25) {
      return 1;
    }
    if (25 < bim && bim <= 30) {
      return 2;
    }
    if (30 < bim && bim <= 35) {
      return 3;
    }
    if (35 < bim && bim <= 40) {
      return 4;
    }
    if (40 < bim) {
      return 5;
    }
    return 0;
  }
}
