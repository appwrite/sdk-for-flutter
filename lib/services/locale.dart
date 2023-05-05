part of appwrite;

/// The Locale service allows you to customize your app based on your users'
/// location.
class Locale extends Service {
  Locale(super.client);

  /// Get User Locale
  ///
  /// Get the current user location based on IP. Returns an object with user
  /// country code, country name, continent name, continent code, ip address and
  /// suggested currency. You can use the locale header to get the data in a
  /// supported language.
  ///
  /// ([IP Geolocation by DB-IP](https://db-ip.com))
  ///
  Future<models.Locale> get() async {
    const String path = '/locale';

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.Locale.fromMap(res.data);
  }

  /// List Continents
  ///
  /// List of all continents. You can use the locale header to get the data in a
  /// supported language.
  ///
  Future<models.ContinentList> listContinents() async {
    const String path = '/locale/continents';

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.ContinentList.fromMap(res.data);
  }

  /// List Countries
  ///
  /// List of all countries. You can use the locale header to get the data in a
  /// supported language.
  ///
  Future<models.CountryList> listCountries() async {
    const String path = '/locale/countries';

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.CountryList.fromMap(res.data);
  }

  /// List EU Countries
  ///
  /// List of all countries that are currently members of the EU. You can use the
  /// locale header to get the data in a supported language.
  ///
  Future<models.CountryList> listCountriesEU() async {
    const String path = '/locale/countries/eu';

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.CountryList.fromMap(res.data);
  }

  /// List Countries Phone Codes
  ///
  /// List of all countries phone codes. You can use the locale header to get the
  /// data in a supported language.
  ///
  Future<models.PhoneList> listCountriesPhones() async {
    const String path = '/locale/countries/phones';

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.PhoneList.fromMap(res.data);
  }

  /// List Currencies
  ///
  /// List of all currencies, including currency symbol, name, plural, and
  /// decimal digits for all major and minor currencies. You can use the locale
  /// header to get the data in a supported language.
  ///
  Future<models.CurrencyList> listCurrencies() async {
    const String path = '/locale/currencies';

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.CurrencyList.fromMap(res.data);
  }

  /// List Languages
  ///
  /// List of all languages classified by ISO 639-1 including 2-letter code, name
  /// in English, and name in the respective language.
  ///
  Future<models.LanguageList> listLanguages() async {
    const String path = '/locale/languages';

    final Map<String, dynamic> params = {};

    final Map<String, String> headers = {
      'content-type': 'application/json',
    };

    final res = await client.call(CallParams(
      HttpMethod.get,
      path,
      params: params,
      headers: headers,
    ));

    return models.LanguageList.fromMap(res.data);
  }
}
