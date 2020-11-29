import 'package:flutter/material.dart';

class ExpensesResume extends StatelessWidget {
  final double budget;
  final double totalSpent;

  const ExpensesResume({@required this.budget, @required this.totalSpent});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: mediaQuery.size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Orçamento:',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$budget',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
                ),
                
              ],
            ),
          ),
          Container(
            width: mediaQuery.size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Total gasto:',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$totalSpent',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: mediaQuery.size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Dísponivel:',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${budget - totalSpent}',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
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
