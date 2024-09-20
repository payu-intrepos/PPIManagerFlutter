import 'package:flutter/material.dart';
import 'package:payu_ppi_flutter_example/HashService.dart';
import 'package:payu_ppi_flutter/payu_ppi_flutter.dart';
import 'package:payu_ppi_flutter/PayUConstantKeys.dart';


void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements PayUPPIProtocol {
  
  late PayUPPIFlutter _ppi;

  @override
  void initState() {
    super.initState();
      _ppi = PayUPPIFlutter(this);
  }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayU PPI SDK'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("Show Cards"),
            onPressed: () async {
              _ppi.showCards(
                payUPPIParams: PayUParams.createPayUPPIParams()
              );
            },
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String content) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,

              child: new Text(content),
            ),
            actions: [okButton],
          );
        });
  }

  @override
  generateHash(Map response) {
    // Pass response param to your backend server
    // Backend will generate the hash and will callback to
    Map hashResponse = HashService.generateHash(response);
    _ppi.hashGenerated(hash: hashResponse);
  }

  @override
  onCancel() {
    showAlertDialog(context, "onCancel", "Cancel By user");
  }

  @override
  onError(Map? response) {
    showAlertDialog(context, "onError", response.toString());
  }
}

class PayUTestCredentials { 
  static const merchantKey = "<merchat key>";//TODO: Add Merchant Key
  //Use your success and fail URL's.
}

//Pass these values from your app to SDK, this data is only for test purpose
class PayUParams {
  static Map createPayUPPIParams() {
    var payUParams = {
      PayUPPIParamKey.merchantKey: PayUTestCredentials.merchantKey,
      PayUPPIParamKey.referenceId: "payu${DateTime.now().millisecondsSinceEpoch}", // inCase of skudDetails pass amount equal to total skuAmount
      PayUPPIParamKey.walletUrn: "<Wallet urn>",
      PayUPPIParamKey.environment: "0",
      PayUPPIParamKey.walletIdentifier: "<Wallet identifier>",
      PayUPPIParamKey.mobileNumber: "<mobile number>"
    };

    return payUParams;
  }
}
