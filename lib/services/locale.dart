part of '../appwrite.dart';

/// The Locale service allows you to customize your app based on your users&#039;
/// location.
class Locale extends Service {
  /// Initializes a [Locale] service
  Locale(super.client);

  /// Get user locale
  ///
  /// Get the current user location based on IP. Returns an object with user
  /// country code, country name, continent name, continent code, ip address and
  /// suggested currency. You can use the locale header to get the data in a
  /// supported language.
  ///
  /// ([IP Geolocation by DB-IP](https://db-ip.com))
  Future<models.Locale> get() async {
    const String apiPath = '/locale';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.Locale.fromMap(res.data);
  }

  /// List Locale Codes
  ///
  /// List of all locale codes in [ISO
  /// 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
  Future<models.LocaleCodeList> listCodes() async {
    const String apiPath = '/locale/codes';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.LocaleCodeList.fromMap(res.data);
  }

  /// List continents
  ///
  /// List of all continents. You can use the locale header to get the data in a
  /// supported language.
  Future<models.ContinentList> listContinents() async {
    const String apiPath = '/locale/continents';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.ContinentList.fromMap(res.data);
  }

  /// List countries
  ///
  /// List of all countries. You can use the locale header to get the data in a
  /// supported language.
  Future<models.CountryList> listCountries() async {
    const String apiPath = '/locale/countries';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.CountryList.fromMap(res.data);
  }

  /// List EU countries
  ///
  /// List of all countries that are currently members of the EU. You can use the
  /// locale header to get the data in a supported language.
  Future<models.CountryList> listCountriesEU() async {
    const String apiPath = '/locale/countries/eu';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.CountryList.fromMap(res.data);
  }

  /// List countries phone codes
  ///
  /// List of all countries phone codes. You can use the locale header to get the
  /// data in a supported language.
  Future<models.PhoneList> listCountriesPhones() async {
    const String apiPath = '/locale/countries/phones';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.PhoneList.fromMap(res.data);
  }

  /// List currencies
  ///
  /// List of all currencies, including currency symbol, name, plural, and
  /// decimal digits for all major and minor currencies. You can use the locale
  /// header to get the data in a supported language.
  Future<models.CurrencyList> listCurrencies() async {
    const String apiPath = '/locale/currencies';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.CurrencyList.fromMap(res.data);
  }

  /// List languages
  ///
  /// List of all languages classified by ISO 639-1 including 2-letter code, name
  /// in English, and name in the respective language.
  Future<models.LanguageList> listLanguages() async {
    const String apiPath = '/locale/languages';

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.LanguageList.fromMap(res.data);
  }
}
