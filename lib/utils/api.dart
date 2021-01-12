import 'dart:convert';
import 'package:http/http.dart' as http;
import 'global.dart';

class API {
  static Future<List<Map<String, dynamic>>> getData() async {
    List<Map<String, dynamic>> list = [];
    List<String> currenciesNickName = [];
    List<String> currenciesName = [];
    http.Response response =
        await http.get('https://forex.cbm.gov.mm/api/latest');
    var data = jsonDecode(response.body)['rates'] as Map;
    data.forEach((key, value) {
      list.add({key: value});
      currenciesNickName.add(key);
      currenciesName.add(getNikName(key));
    });
    Global.dataList = list;
    Global.currenciesNickName = currenciesNickName;
    Global.currenciesName = currenciesName;

    return Global.dataList;
  }

  static String getNikName(String name) {
    if (name == 'USD') {
      return 'United State Dollar';
    } else if (name == 'EUR') {
      return 'Euro';
    } else if (name == 'SGD') {
      return 'Singapore Dollar';
    } else if (name == 'GBP') {
      return 'Pound Sterling';
    } else if (name == 'CHF') {
      return 'Swiss Franc';
    } else if (name == 'JPY') {
      return 'Japanese Yen';
    } else if (name == 'AUD') {
      return 'Australian Dollar';
    } else if (name == 'BDT') {
      return 'Bangladesh Taka';
    } else if (name == 'BND') {
      return 'Brunei Dollar';
    } else if (name == 'KHR') {
      return 'Cambodian Riel';
    } else if (name == 'CAD') {
      return 'Canadian Dollar';
    } else if (name == 'CNY') {
      return 'Chinese Yuan';
    } else if (name == 'HKD') {
      return 'Hong Kong Dollar';
    } else if (name == 'INR') {
      return 'Indian Rupee';
    } else if (name == 'IDR') {
      return 'Indonesian Rupiah';
    } else if (name == 'KRW') {
      return 'Korean Won';
    } else if (name == 'LAK') {
      return 'Lao Kip';
    } else if (name == 'MYR') {
      return 'Malaysian Ringgit';
    } else if (name == 'NZD') {
      return 'New Zealand Dollar';
    } else if (name == 'PKR') {
      return 'Pakistani Rupee';
    } else if (name == 'PHP') {
      return 'Philippines Peso';
    } else if (name == 'LKR') {
      return 'Sri Lankan Rupee';
    } else if (name == 'THB') {
      return 'Thai Baht';
    } else if (name == 'VND') {
      return 'Vietnamese Dong';
    } else if (name == 'BRL') {
      return 'Brazilian Real';
    } else if (name == 'CZK') {
      return 'Czech Koruna';
    } else if (name == 'DKK') {
      return 'Danish Krone';
    } else if (name == 'EGP') {
      return 'Egyptian Pound';
    } else if (name == 'ILS') {
      return 'Israeli Shekel';
    } else if (name == 'KES') {
      return 'Kenya Shilling';
    } else if (name == 'KWD') {
      return 'Kuwaiti Dinar';
    } else if (name == 'NPR') {
      return 'Nepalese Rupee';
    } else if (name == 'NOK') {
      return 'Norwegian Kroner';
    } else if (name == 'RUB') {
      return 'Russian Rouble';
    } else if (name == 'SAR') {
      return 'Saudi Arabian Riyal';
    } else if (name == 'RSD') {
      return 'Serbian Dinar';
    } else if (name == 'ZAR') {
      return 'South Africa Rand';
    } else if (name == 'SEK') {
      return 'Swedish Krona';
    } else {
      return 'Unknown';
    }
  }
}
