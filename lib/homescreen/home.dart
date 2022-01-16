import 'package:cripte/homescreen/transactions/transactions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropDownValue = "Ethereum Mainnet (1)";
  int chainId = 1;
  late String address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Cripte",
            style: TextStyle(
                color: Colors.black, fontFamily: 'BebasNeue', fontSize: 36),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
            onChanged: (value) {
              address = value;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                labelStyle: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButton<String>(
            value: dropDownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(
                color: Colors.black, fontFamily: "BebasNeue", fontSize: 26),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                if (newValue == "Ethereum Mainnet (1)") {
                  chainId = 1;
                } else if (newValue == "Matic Mainnet (137)") {
                  chainId = 137;
                } else if (newValue == "Avalanche C-Chain Mainnet (43114)") {
                  chainId = 43114;
                } else if (newValue == "Binance Smart Chain (56)") {
                  chainId = 56;
                } else if (newValue == "Moonbeam Moonriver (1285)") {
                  chainId = 1285;
                } else if (newValue == "RSK Mainnet (30)") {
                  chainId = 30;
                } else if (newValue == "Arbitrum Mainnet (42161)") {
                  chainId = 42161;
                } else if (newValue == "Fantom Opera (250)") {
                  chainId = 250;
                } else if (newValue == "Palm Mainnet (11297108109)") {
                  chainId = 11297108109;
                } else if (newValue == "Klaytn Mainnet (8217)") {
                  chainId = 8217;
                } else if (newValue == "HECO Mainnet (128)") {
                  chainId = 128;
                } else if (newValue == "Axie Mainnet (2020)") {
                  chainId = 2020;
                } else if (newValue == "Astar Shiden (336)") {
                  chainId = 336;
                } else if (newValue == "IoTeX Mainnet (4689)") {
                  chainId = 4689;
                } else {
                  chainId = 1;
                }
              });
            },
            items: <String>[
              "Ethereum Mainnet (1)",
              "Matic Mainnet (137)",
              "Avalanche C-Chain Mainnet (43114)",
              "Binance Smart Chain (56)",
              "Moonbeam Moonriver (1285)",
              "RSK Mainnet (30)",
              "Arbitrum Mainnet (42161)",
              "Fantom Opera (250)",
              "Palm Mainnet (11297108109)",
              "Klaytn Mainnet (8217)",
              "HECO Mainnet (128)",
              "Axie Mainnet (2020)",
              "Astar Shiden (336)",
              "IoTeX Mainnet (4689)",
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(
            height: 50.0,
            child: Material(
              borderRadius: BorderRadius.circular(5.0),
              shadowColor: Colors.black54,
              color: Colors.black,
              elevation: 7.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Transactions(
                              address: address,
                              chainId: chainId,
                            )),
                  );
                },
                child: const Center(
                  child: Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BebasNeue'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
