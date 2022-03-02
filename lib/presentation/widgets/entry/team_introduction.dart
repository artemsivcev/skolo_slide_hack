import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/entry_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/entry/team_member.dart';

class TeamIntroduction extends StatefulWidget {
  const TeamIntroduction({Key? key}) : super(key: key);

  @override
  State<TeamIntroduction> createState() => _TeamIntroductionState();
}

class _TeamIntroductionState extends State<TeamIntroduction> {
  final List<String> membersNames = ['Artem', 'Dasha', 'Maxim', 'Chris'];
  final List<String> membersGithubNames = [
    'artemsivcev',
    'DariaDe',
    'MaximRyabovol',
    'christina-bel'
  ];

  final screenState = injector<ScreenState>();
  final entryAnimationState = injector<EntryAnimationState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async => await entryAnimationState.startBreakingGlass(),
        child: Container(
          color: colorsWhitePrimary,
          child: Observer(
            builder: (context) {
              var usedMobileVersion = screenState.usedMobileVersion;
              var isHeightBigger = screenState.isPortrait(context);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: usedMobileVersion ? 'OUR ' : 'OUR\n',
                      style: const TextStyle(
                        fontFamily: 'LuckiestGuy-Regular',
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4,
                        color: blackColour,
                      ),
                      children: const [
                        TextSpan(
                          text: 'TEAM',
                          style: TextStyle(
                            fontFamily: 'LuckiestGuy-Regular',
                            fontSize: 52,
                            letterSpacing: 5,
                            fontWeight: FontWeight.w900,
                            color: colorsPurpleBluePrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: isHeightBigger ? 2 : 4,
                    childAspectRatio: 0.9,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      membersNames.length,
                      (ind) => TeamMember(
                        name: membersNames[ind],
                        github: membersGithubNames[ind],
                      ),
                    ),
                  ),
                  Text(
                    'game'.tr(),
                    style: const TextStyle(
                      fontFamily: 'AmaticSC',
                      fontSize: 50,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w900,
                      color: blackColour,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
