part of '../../enums.dart';

enum CreditCard {
    americanExpress(value: 'amex'),
    argencard(value: 'argencard'),
    cabal(value: 'cabal'),
    cencosud(value: 'cencosud'),
    dinersClub(value: 'diners'),
    discover(value: 'discover'),
    elo(value: 'elo'),
    hipercard(value: 'hipercard'),
    jCB(value: 'jcb'),
    mastercard(value: 'mastercard'),
    naranja(value: 'naranja'),
    tarjetaShopping(value: 'targeta-shopping'),
    unionChinaPay(value: 'union-china-pay'),
    visa(value: 'visa'),
    mIR(value: 'mir'),
    maestro(value: 'maestro'),
    rupay(value: 'rupay');

    const CreditCard({
        required this.value
    });

    final String value;

    String toJson() => value;
}