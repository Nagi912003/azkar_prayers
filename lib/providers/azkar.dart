import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Azkar with ChangeNotifier {
  static const _azkar = [
    'سُبْحَانَ اَللَّهِ',
    'اَلْحَمْد لِلَّهِ',
    'لَا إِلَهَ إِلَّا اَللَّهُ',
    'اَللَّه أَكْبَرَ',
    'اَللَّهُمَّ صَلَّى عَلِي مُحَمَّدْ وَعَلَى آلِهِ وَصَحْبِهِ وَسَلَّمَ',
    'لَا إِلَهَ إِلَّا اَللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ ، لَهُ اَلْمَلِكُ وَلَهُ اَلْحَمْدُ وَهُوَ عَلِي كُلَّ شَيْءٍ قَدِيرٍ',
    'سُبْحَانَ اَللَّهِ وَبِحَمْدِهِ',
    'أَسْتَغْفِرُ اَللَّهُ اَلْعَظِيمُ وَأَتُوبُ إِلَيْهِ',
    'سُبْحَانَ اَللَّهِ وَبِحَمْدٍ ، سُبْحَانَ اَللَّهِ اَلْعَظِيمِ',
    'لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنْ اَلظَّالِمِينَ',
    'سُبْحَانَ اَللَّهِ وَبِحَمْدِهِ ، عَدَدُ خُلُقِهِ ، وَرِضَا نَفْسِهِ ، وَزْنُهُ عَرْشُهُ ، وَمِدَادَ كَلِمَاتِهِ',
    'بِسْمِ اَللَّهِ اَلَّذِي لَا يَضُرُّ مَعَ اِسْمِهِ شَيْءً فِي اَلْأَرْضِ وَلَا فِي اَلسَّمَاءِ وَهُوَ اَلسَّمِيعْ اَلْعَلِيمِ',
    'اَللَّهُمَّ صَلَّى عَلِي مُحَمَّدْ وَعَلِي آلَ مُحَمَّدْ ، كَمَا صُلِّيَتْ عَلِي إِبْرَاهِيمْ وَعَلِي آلَ إِبْرَاهِيمْ ، إِنَّكَ حَمِيدْ مَجِيدْ ، وَبَارَكَ عَلِي مُحَمَّدْ وَعَلِي آلَ مُحَمَّدْ كَمَا بَارَكَتْ عَلِي إِبْرَاهِيمْ وَعَلِي آلَ إِبْرَاهِيمْ ، إِنَّكَ حَمِيدْ مَجِيدْ',
    '',
  ];

  static List get azkar {
    return [..._azkar];
  }

  final box = Hive.box('box');

  bool didDayDateChange() {
    if (!box.containsKey('dayDate')) {
      box.put('dayDate', DateTime.now());
      return true;
    }
    var date = DateTime.now();
    final savedDate = box.get('dayDate');

    if (date.day != savedDate.day ||
        date.month != savedDate.month ||
        date.year != savedDate.year) {
      box.put('dayDate', DateTime.now());
      return true;
    }
    return false;
  }

  bool didMonthDateChange() {
    if (!box.containsKey('monthDate')) {
      box.put('monthDate', DateTime.now());
      return true;
    }
    var date = DateTime.now();
    final savedDate = box.get('monthDate');

    if (date.month != savedDate.month ||
        date.year != savedDate.year) {
      box.put('monthDate', DateTime.now());
      return true;
    }
    return false;
  }

  void increaseCounter(int c, int index) {
    Hive.box('box').put('current$index', c);

    int dailyCounter = Hive.box('box').get('daily$index', defaultValue: 0);
    int monthlyCounter = Hive.box('box').get('monthly$index', defaultValue: 0);
    int totalCounter = Hive.box('box').get('total$index', defaultValue: 0);

    if(didDayDateChange()) {
      dailyCounter = 0;
    }
    if(didMonthDateChange()) {
      monthlyCounter = 0;
    }

    dailyCounter++;
    monthlyCounter++;
    totalCounter++;

    Hive.box('box').put('daily$index', dailyCounter);
    Hive.box('box').put('monthly$index', monthlyCounter);
    Hive.box('box').put('total$index', totalCounter);
    notifyListeners();
  }

}