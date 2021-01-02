import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesOverview extends StatefulWidget {
  @override
  _ExpensesOverviewState createState() => _ExpensesOverviewState();
}

class _ExpensesOverviewState extends State<ExpensesOverview> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final backGroundColor = Color.fromRGBO(25, 184, 197, 1);
    final greenColor = Color.fromRGBO(6, 175, 47, 1);
    final redColor = Color.fromRGBO(200, 6, 6, 1);
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Gaste menos!'),
        backgroundColor: backGroundColor,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.05,
            ),
            height: screenHeight * 0.4,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: greenColor,
                      size: 35,
                    ),
                    title: Text(
                      "R\$ 2000,00",
                      style: TextStyle(
                        fontSize: 25,
                        color: greenColor,
                      ),
                    ),
                    subtitle: Text(
                      "Orçamento",
                      style: TextStyle(color: greenColor),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.money_off,
                    color: redColor,
                    size: 35,
                  ),
                  title: Text(
                    "R\$ 2000,00",
                    style: TextStyle(
                      fontSize: 25,
                      color: redColor,
                    ),
                  ),
                  subtitle: Text(
                    "Total Gasto",
                    style: TextStyle(color: redColor),
                  ),
                  trailing: FlatButton(
                    onPressed: () {},
                    child: Text('Alterar'),
                    color: backGroundColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
