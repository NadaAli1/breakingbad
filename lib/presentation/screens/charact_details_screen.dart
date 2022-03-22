import 'dart:math';

import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      endIndent: endIndent,
      height: 20,
      thickness: 2,
    );
  }

  Widget ifQuotesAreLoaded(CharactersState state) {
    if (state is CharactersLoaded) {
      return displayRandomQuotesOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuotesOrEmptySpace(state) {
    var quotesList = (state).quote;
    if (quotesList.lenght != 0) {
      int randomQuoteIndex = Random().nextInt(quotesList.lenght - 1);
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 20,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FlickerAnimatedText(quotesList[randomQuoteIndex].quote),
            ],
            isRepeatingAnimation: true,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);

    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                        'Job : ',
                        character.jobs.join(' / '),
                      ),
                      buildDivider(278),
                      characterInfo(
                          'Appeared In : ', character.categoryInTwoSeries),
                      buildDivider(212),
                      character.appearanceInSeason.isEmpty
                          ? Container()
                          : characterInfo(
                              'Seasons : ',
                              character.appearanceInSeason.join(' / '),
                            ),
                      character.appearanceInSeason.isEmpty
                          ? Container()
                          : buildDivider(240),
                      characterInfo(
                          'Status : ', character.statuesIfDeadOrAlive),
                      buildDivider(253),
                      character.betterCallSoulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              'Better Call Saul Seasons : ',
                              character.betterCallSoulAppearance.join(' / '),
                            ),
                      character.betterCallSoulAppearance.isEmpty
                          ? Container()
                          : buildDivider(112),
                      characterInfo('Actor / Actress  : ', character.actorName),
                      buildDivider(185),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return ifQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
