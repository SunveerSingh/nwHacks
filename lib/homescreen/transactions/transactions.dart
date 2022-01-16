import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  String address;
  int chainId;
  Transactions({Key? key, required this.address, required this.chainId})
      : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int pagenumber = 1;
  late Future<List<dynamic>> futuredata;
  @override
  void initState() {
    super.initState();
    futuredata = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://api.covalenthq.com/v1/${widget.chainId}/address/${widget.address}/transactions_v2/?key=ckey_6f8f8b26e12743b19e8871699da'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data']["items"];
    }
    if (response.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${response.statusCode}');
    } else {
      throw Exception('Failed to load');
    }
  }

  String from_address(dynamic user) {
    return user['from_address'];
  }

  String txn_hash(dynamic user) {
    return user['tx_hash'];
  }

  String to_address(dynamic user) {
    return user['to_address'];
  }

  String block_signed_at(dynamic user) {
    return user["block_signed_at"];
  }

  int gas_price(dynamic user) {
    return user["gas_price"];
  }

  int gas_offered(dynamic user) {
    return user["gas_offered"];
  }

  int gas_spent(dynamic user) {
    return user["gas_spent"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Text(
            "Transaction History",
            style: TextStyle(
                fontFamily: "BebasNeue", fontSize: 32, color: Colors.black),
          ),
        ),
        Container(
          child: showTransactionHistory(),
          height: 500,
        ),
      ],
    ));
  }

  FutureBuilder<List<dynamic>> showTransactionHistory() {
    return FutureBuilder<List<dynamic>>(
      future: futuredata,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Time Stamp: ${block_signed_at(snapshot.data[index])}",
                            style: TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 22,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "TXN Hash: ${txn_hash(snapshot.data[index]).substring(0, 25)}...",
                            style: TextStyle(
                                fontFamily: 'BebasNeue',
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_right_alt_rounded,
                              ),
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                      "TXN Hash: ${txn_hash(snapshot.data[index])}",
                                      style: TextStyle(
                                          fontFamily: 'BebasNeue',
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Time Stamp: ${block_signed_at(snapshot.data[index])}",
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "To Address: ${to_address(snapshot.data[index])}",
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "From Address: ${from_address(snapshot.data[index])}",
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Gas Offered: ${gas_offered(snapshot.data[index])}",
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Gas Spent: ${gas_spent(snapshot.data[index])}",
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Gas Price: ${gas_price(snapshot.data[index])}",
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
