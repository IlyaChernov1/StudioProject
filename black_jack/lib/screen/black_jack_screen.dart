import 'dart:math';
import 'package:flutter/material.dart';
import 'package:black_jack/widgets/cards_grid_view.dart';
import 'package:black_jack/widgets/my_button.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({super.key});

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool isGameStarted = false;

  List<Image> myCards = [];
  List<Image> dealersCards = [];

  String? playersFirstCard;
  String? playersSecondCard;

  String? dealersFirstCard;
  String? dealersSecondCard;

  int playerScore = 0;
  int dealerScore = 0;

  final Map<String, int> deckOfCards = {
    "Cards/2.1.png": 2,
    "Cards/2.2.png": 2,
    "Cards/2.3.png": 2,
    "Cards/2.4.png": 2,
    "Cards/3.1.png": 3,
    "Cards/3.2.png": 3,
    "Cards/3.3.png": 3,
    "Cards/3.4.png": 3,
    "Cards/4.1.png": 4,
    "Cards/4.2.png": 4,
    "Cards/4.3.png": 4,
    "Cards/4.4.png": 4,
    "Cards/5.1.png": 5,
    "Cards/5.2.png": 5,
    "Cards/5.3.png": 5,
    "Cards/5.4.png": 5,
    "Cards/6.1.png": 6,
    "Cards/6.2.png": 6,
    "Cards/6.3.png": 6,
    "Cards/6.4.png": 6,
    "Cards/7.1.png": 7,
    "Cards/7.2.png": 7,
    "Cards/7.3.png": 7,
    "Cards/7.4.png": 7,
    "Cards/8.1.png": 8,
    "Cards/8.2.png": 8,
    "Cards/8.3.png": 8,
    "Cards/8.4.png": 8,
    "Cards/9.1.png": 9,
    "Cards/9.2.png": 9,
    "Cards/9.3.png": 9,
    "Cards/9.4.png": 9,
    "Cards/10.1.png": 10,
    "Cards/10.2.png": 10,
    "Cards/10.3.png": 10,
    "Cards/10.4.png": 10,
    "Cards/J1.png": 10,
    "Cards/J2.png": 10,
    "Cards/J3.png": 10,
    "Cards/J4.png": 10,
    "Cards/Q1.png": 10,
    "Cards/Q2.png": 10,
    "Cards/Q3.png": 10,
    "Cards/Q4.png": 10,
    "Cards/K1.png": 10,
    "Cards/K2.png": 10,
    "Cards/K3.png": 10,
    "Cards/K4.png": 10,
    "Cards/A1.png": 11,
    "Cards/A2.png": 11,
    "Cards/A3.png": 11,
    "Cards/A4.png": 11,
  };

  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  void changeCards() {
    setState(() => isGameStarted = true);

    playingCards = {};
    playingCards.addAll(deckOfCards);

    myCards = [];
    dealersCards = [];

    Random random = Random();

    String cardOneKey = playingCards.keys.elementAt(
        random.nextInt(playingCards.length));
    playingCards.remove(cardOneKey);

    String cardTwoKey = playingCards.keys.elementAt(
        random.nextInt(playingCards.length));
    playingCards.remove(cardTwoKey);

    String cardThreeKey = playingCards.keys.elementAt(
        random.nextInt(playingCards.length));
    playingCards.remove(cardThreeKey);

    String cardFourKey = playingCards.keys.elementAt(
        random.nextInt(playingCards.length));
    playingCards.remove(cardFourKey);

    dealersFirstCard = cardOneKey;
    dealersSecondCard = cardTwoKey;

    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;

    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));

    dealerScore =
        deckOfCards[dealersFirstCard]! + deckOfCards[dealersSecondCard]!;

    myCards.add(Image.asset(playersFirstCard!));
    myCards.add(Image.asset(playersSecondCard!));

    playerScore =
        deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!;

    if (dealerScore <= 14) {
      String thirdDealersCardKey = playingCards.keys.elementAt(
          random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == thirdDealersCardKey);

      dealersCards.add(Image.asset(thirdDealersCardKey));

      dealerScore = dealerScore + deckOfCards[thirdDealersCardKey]!;
    }
  }

  void addCard() {
    Random random = Random();

    if (playingCards.isNotEmpty) {
      String cardKey = playingCards.keys.elementAt(
          random.nextInt(playingCards.length));
      playingCards.remove(cardKey);

      setState(() {
        myCards.add(Image.asset(cardKey));
      });

      playerScore += deckOfCards[cardKey]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGameStarted
          ? SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Dealer's Cards
              Column(
                children: [
                  Text("Dealer's score: $dealerScore", style: TextStyle(
                      color: dealerScore <= 21 ? Colors.green[900] : Colors.red[900]
                  ),),
                  SizedBox(height: 20),

                  Container(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: dealersCards.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: dealersCards[index],
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Player's Cards
              Column(
                children: [
                  Text("Player's score: $playerScore", style: TextStyle(
                      color: playerScore <= 21 ? Colors.green[900] : Colors.red[900]
                  ),),
                  SizedBox(height: 20),
                  //GridView
                  CardsGridView(cards: myCards),
                ],
              ),

              // 2 Buttons
              IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyButton(onPressed: addCard, label:"Another Card"),
                    MyButton(onPressed: changeCards, label:"Next Round"),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          : Center(
        child:  MyButton(onPressed: changeCards, label:"Start Game"),
      ),
    );
  }
}




