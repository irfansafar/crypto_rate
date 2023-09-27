import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getUrl(toCurrency) async {
  var from = 'BTC';
  var to = toCurrency;

  var url = await http.get(
    Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$from/$to?apikey=4E0A0149-A418-457A-AC1D-DA98DB49C9DA'),
  );

  String urlData = url.body;
  double btcUSD = jsonDecode(urlData)['rate'];
  return btcUSD;
}
