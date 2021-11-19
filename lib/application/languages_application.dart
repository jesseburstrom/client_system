part of "../main.dart";

class LanguagesApplication extends LanguagesApplicationSettings {
  final _ones = {"English": "Ones"};
  final _twos = {"English": "Twos"};
  final _threes = {"English": "Threes"};
  final _fours = {"English": "Fours"};
  final _fives = {"English": "Fives"};
  final _sixes = {"English": "Sixes"};
  final _sum = {"English": "Sum"};
  final _bonus = {"English": "Bonus"};
  final _pair = {"English": "Pair"};
  final _twoPairs = {"English": "Two Pairs"};
  final _threePairs = {"English": "Three Pairs"};
  final _threeOfKind = {"English": "Three of a Kind"};
  final _fourOfKind = {"English": "Four of a Kind"};
  final _fiveOfKind = {"English": "Five of a Kind"};
  final _house = {"English": "House"};
  final _smallStraight = {"English": "Small Straight"};
  final _largeStraight = {"English": "Large Straight"};
  final _fullStraight = {"English": "Full Straight"};
  final _middleStraight = {"English": "Middle Straight"};
  final _house32 = {"English": "House 3+2"};
  final _house33 = {"English": "House 3+3"};
  final _house24 = {"English": "House 2+4"};
  final _chance = {"English": "Chance"};
  final _yatzy = {"English": "Yatzy"};
  final _maxiYatzy = {"English": "Maxi Yatzy"};
  final _totalSum = {"English": "Total Sum"};
  final _turn = {"English": "turn..."};
  final _your = {"English": "Your"};

  String get ones_ => getText(_ones);

  String get twos_ => getText(_twos);

  String get threes_ => getText(_threes);

  String get fours_ => getText(_fours);

  String get fives_ => getText(_fives);

  String get sixes_ => getText(_sixes);

  String get sum_ => getText(_sum);

  String get bonus_ => getText(_bonus);

  String get pair_ => getText(_pair);

  String get twoPairs_ => getText(_twoPairs);

  String get threePairs_ => getText(_threePairs);

  String get threeOfKind_ => getText(_threeOfKind);

  String get fourOfKind_ => getText(_fourOfKind);

  String get fiveOfKind_ => getText(_fiveOfKind);

  String get house_ => getText(_house);

  String get smallStraight_ => getText(_smallStraight);

  String get largeStraight_ => getText(_largeStraight);

  String get fullStraight_ => getText(_fullStraight);

  String get middleStraight_ => getText(_middleStraight);

  String get house32_ => getText(_house32);

  String get house33_ => getText(_house33);

  String get house24_ => getText(_house24);

  String get chance_ => getText(_chance);

  String get yatzy_ => getText(_yatzy);

  String get maxiYatzy_ => getText(_maxiYatzy);

  String get totalSum_ => getText(_totalSum);

  String get turn_ => getText(_turn);

  String get your_ => getText(_your);

  @override
  languagesSetup() {
    super.languagesSetup();
    _ones["Swedish"] = "Ettor";
    _twos["Swedish"] = "Tvåor";
    _threes["Swedish"] = "Treor";
    _fours["Swedish"] = "Fyror";
    _fives["Swedish"] = "Femmor";
    _sixes["Swedish"] = "Sexor";
    _sum["Swedish"] = "Summa";
    _bonus["Swedish"] = "Bonus";
    _pair["Swedish"] = "Par";
    _twoPairs["Swedish"] = "Två Par";
    _threePairs["Swedish"] = "Tre Par";
    _threeOfKind["Swedish"] = "Triss";
    _fourOfKind["Swedish"] = "Fyrtal";
    _fiveOfKind["Swedish"] = "Fem i Rad";
    _house["Swedish"] = "Kåk";
    _smallStraight["Swedish"] = "Liten Stege";
    _largeStraight["Swedish"] = "Stor Stege";
    _fullStraight["Swedish"] = "Hel Stege";
    _middleStraight["Swedish"] = "Mellan Stege";
    _house32["Swedish"] = "Kåk 3+2";
    _house33["Swedish"] = "Kåk 3+3";
    _house24["Swedish"] = "Kåk 2+4";
    _chance["Swedish"] = "Chans";
    _yatzy["Swedish"] = "Yatzy";
    _maxiYatzy["Swedish"] = "Maxi Yatzy";
    _totalSum["Swedish"] = "Total Summa";
    _turn["Swedish"] = "tur...";
    _your["Swedish"] = "Din";
  }
}
