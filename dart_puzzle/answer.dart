// CODING GAME prompt here: https://www.codingame.com/ide/puzzle/card-counting-when-easily-distracted

import 'dart:io';
import 'dart:math';

String readLineSync() {
  String? s = stdin.readLineSync();
  return s == null ? '' : s;
}

int getValueOfCard (String card) {
  var conf = {
    "A" : 1, 
    "T" : 10, 
    "J" : 11, 
    "Q" : 12, 
    "K" : 13,
  };
  if (['K', 'Q', 'J', 'T', 'A'].contains(card)){
    return conf[card]!;
  }
  return int.parse(card);
}

bool isValidCard(String card){
  return [ "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"].contains(card); 
}

List<int> getCardsIfValidThought(String thought){
  List<int> cards = [];
  for (String potentialCard in thought.split('')){
    if(isValidCard(potentialCard)){
      cards.add(getValueOfCard(potentialCard));
    }
    else {
      return [];
    }

  }
  return cards; 
}

List<int> createFullDeck (){
  List<int> deck = []; 
  int i = 1; 
  while (i < 14){
    deck.addAll([i, i, i, i]);
    i++; 
  }
  return deck; 
}

void main() {
    String streamOfConsciousness = readLineSync();
    int bustThreshold = int.parse(readLineSync());
    List<int> deck = createFullDeck();
  
    for (String thought in streamOfConsciousness.split('.')){
       List<int> cardsList = getCardsIfValidThought(thought);

       for (int card in cardsList){
        int indexInDeck = deck.indexOf(card);
        if(indexInDeck != -1){
          deck.removeAt(indexInDeck);
        }
       }
    }

    int cardsUnderThreshold = deck.where((card) => card < bustThreshold).length; 
    double percentageChance = cardsUnderThreshold / deck.length * 100; 

    print("${percentageChance.round()}%");
}