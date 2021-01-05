import 'package:despesa_pessoal/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionTypeIcons {

  static Icon getIcon(TransactionType type){
    if(type == TransactionType.UBER){
      return Icon(Icons.car_rental);
    }
    if(type == TransactionType.BILL){
      return Icon(Icons.card_giftcard);
    }
    if(type == TransactionType.SHOPPING){
      return Icon(Icons.shop);
    }
    if(type == TransactionType.FOOD){
      return Icon(Icons.food_bank);
    }
    return null;
  }
}