part of '../../enums.dart';

enum OAuthProvider {
  amazon(value: 'amazon'),
  apple(value: 'apple'),
  auth0(value: 'auth0'),
  authentik(value: 'authentik'),
  autodesk(value: 'autodesk'),
  bitbucket(value: 'bitbucket'),
  bitly(value: 'bitly'),
  box(value: 'box'),
  dailymotion(value: 'dailymotion'),
  discord(value: 'discord'),
  disqus(value: 'disqus'),
  dropbox(value: 'dropbox'),
  etsy(value: 'etsy'),
  facebook(value: 'facebook'),
  github(value: 'github'),
  gitlab(value: 'gitlab'),
  google(value: 'google'),
  linkedin(value: 'linkedin'),
  microsoft(value: 'microsoft'),
  notion(value: 'notion'),
  oidc(value: 'oidc'),
  okta(value: 'okta'),
  paypal(value: 'paypal'),
  paypalSandbox(value: 'paypalSandbox'),
  podio(value: 'podio'),
  salesforce(value: 'salesforce'),
  slack(value: 'slack'),
  spotify(value: 'spotify'),
  stripe(value: 'stripe'),
  tradeshift(value: 'tradeshift'),
  tradeshiftBox(value: 'tradeshiftBox'),
  twitch(value: 'twitch'),
  wordpress(value: 'wordpress'),
  yahoo(value: 'yahoo'),
  yammer(value: 'yammer'),
  yandex(value: 'yandex'),
  zoho(value: 'zoho'),
  zoom(value: 'zoom'),
  mock(value: 'mock');

  const OAuthProvider({required this.value});

  final String value;

  String toJson() => value;
}
