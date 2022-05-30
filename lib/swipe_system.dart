import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

//Custom swiping widget
class SwipingWidget extends StatefulWidget {
  //Cards that will loaded on initialization
  final List<JokeCard> startingCards;

  //When card swiped, this function will be called
  final Function onSwiped;

  const SwipingWidget(
      {Key? key, required this.onSwiped, required this.startingCards})
      : super(key: key);

  @override
  State<SwipingWidget> createState() => _SwipingWidget();
}

//The main switching widget. Will display appropriate widget depending on state of application.
class _SwipingWidget extends State<SwipingWidget> {
  //List of widgets to display on stack
  late List<Widget> cardList;

  //Controller for automatic swiping when like button pressed
  late AppinioSwiperController swiperController;

  //Every time card is removed, this method will be called
  void _onRemoveCard() {
    super.widget.onSwiped(
        _addCard("Internet connection lost",
            const AssetImage("assets/images/connection_lost.png")),
        this);
  }

  //Replace card by reference to it
  void replace(JokeCard toReplace, JokeCard newCard) {
    setState(() {
      cardList[cardList.indexOf(toReplace)] = newCard;
    });
  }

  //Adds new card to swiping widget
  JokeCard _addCard(String jokeText, ImageProvider image) {
    JokeCard card = JokeCard(jokeText: jokeText, image: image);
    setState(() {
      cardList.insert(0, card);
    });
    return card;
  }

  @override
  void initState() {
    super.initState();
    cardList = List.from(super.widget.startingCards.reversed);
    swiperController = AppinioSwiperController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: AppinioSwiper(
          controller: swiperController,
          cards: cardList,
          onSwipe: (details) {
            _onRemoveCard();
          },
        )),
        ElevatedButton.icon(
          //Like button (task requirement)
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xff4c4f56))),
          onPressed: () {
            swiperController
                .swipe(); //Automatic swipe of card, when button is pressed
          },
          label: const Text(
            "Like",
            style: TextStyle(fontSize: 20),
          ),
          icon: const Icon(
            Icons.favorite,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }
}

//Widget that represents card
class JokeCard extends StatelessWidget {
  //Text of a joke
  final String jokeText;

  //Image provider to load appropriate image
  final ImageProvider image;

  const JokeCard({super.key, required this.jokeText, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          color: const Color.fromARGB(150, 0, 0, 0),
          child: Text(
            jokeText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ));
  }
}
