import 'dart:async';

import 'package:flutter/material.dart';
import 'package:worm/page/pembayaran/detailPayment.dart';
import 'package:worm/model/paymentModel.dart';
import 'package:worm/service/paymentService.dart';

class payment extends StatefulWidget {
  const payment({Key? key}) : super(key: key);

  @override
  State<payment> createState() => _payment();
}

class _payment extends State<payment> {
  late Future<Payment> _payment;
  int id = 0;

  @override
  void initState() {
    super.initState();
    _payment = PaymentService().getAllPayment();
  }

  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(18.0)),
            Padding(padding: EdgeInsets.only(top: 8)),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
              child: Column(
                children: <Widget>[
                  Container(
                    child: const Text(
                      "Rekap Pembayaran",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color.fromARGB(255, 24, 24, 24),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder(
                      future: _payment,
                      builder: (context, AsyncSnapshot<Payment> snapshot) {
                        var state = snapshot.connectionState;
                        if (state != ConnectionState.done) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                var scedule = snapshot.data!.data[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const detailPayment();
                                    }));
                                  },
                                  child: listItem(scedule),
                                );
                              },
                              itemCount: snapshot.data!.data.length,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                              ),
                            );
                          } else {
                            return Text('');
                          }
                        }
                      },
                    ),
          ]),
    );
  }

  Widget InkWell(payments view) {
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              title: Text("Maret 2022"),
              trailing: Text(
                "Masih utang la bang",
                style: TextStyle(color: Colors.red),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Wedding Organize"),
              subtitle: Text(
                "Rp100.000.000,-",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return detailPayment();
              })),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "Terbayar",
                style: TextStyle(color: Color(0xFF666D66)),
              ),
              trailing: Text(
                "Rp20.000,-",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
