import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'first_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            ConnectivityResult res = snapShot.data!;
            switch (res) {
              case ConnectivityResult.mobile:
                return Center(
                  child: First_Page(),
                );
              case ConnectivityResult.wifi:
                return Center(
                  child: First_Page(),
                );
              case ConnectivityResult.vpn:
                return Center(
                  child: First_Page(),
                );
              case ConnectivityResult.other:
                return Center(
                  child: First_Page(),
                );
              case ConnectivityResult.ethernet:
                return Center(
                  child: First_Page(),
                );
              case ConnectivityResult.none:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        child: Image.asset(
                          "assets/images/no_internet.gif",
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.03,
                      ),
                      const Text(
                        "NO INTERNET CONNECTION",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      const Text("Check your internet connection"),
                      const Text("and try again"),
                    ],
                  ),
                );
              case ConnectivityResult.bluetooth:
                return Center(
                  child: First_Page(),
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.brown,
                  ),
                );
            }
          } else if (snapShot.hasError) {
            return Center(
              child: Text(
                snapShot.error.toString(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.brown,
              ),
            );
          }
        },
      ),
    );
  }
}
