part of '../feature.dart';

class _MyHousesScreen extends StatelessWidget {
  const _MyHousesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: getMainAppTheme(context).colors.bgColor, body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(children: const [
        SizedBox(
          height: 64,
        ),
        _ChooseHomeWidget(),
        SizedBox(
          height: 16,
        ),
        _ManagerWidget(),
        SizedBox(
          height: 16,
        ),
        _WhatsappWidget()
      ]),
    );
  }
}
// SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: const EmptyPlaceholderWithLottie(
//               lottiePath: 'assets/lottie/home.json',
//               margin: EdgeInsets.only(bottom: 110, left: 20),
//               title: 'haveNotHomes',
//             ),
//           ),
//         ],
//       ),
//     );

class _ChooseHomeWidget extends StatelessWidget {
  const _ChooseHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Stack(
          children: [
            SvgPicture.asset(
              getMainAppTheme(context).icons.homeWithNumber,
              color: getMainAppTheme(context).colors.bgColor,
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 17,
              child: Text(
                '25',
                textAlign: TextAlign.center,
                style: getMainAppTheme(context)
                    .textStyles
                    .subBody
                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '7й микрорайон',
              style: getMainAppTheme(context)
                  .textStyles
                  .body
                  .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '120 жильцов',
              style: getMainAppTheme(context)
                  .textStyles
                  .subBody
                  .copyWith(color: getMainAppTheme(context).colors.inactiveText),
            ),
          ]),
        ),
        const SizedBox(
          width: 8,
        ),
        SvgPicture.asset(
          getMainAppTheme(context).icons.chevronDown,
          color: getMainAppTheme(context).colors.activeColor,
        )
      ]),
    );
  }
}

class _WhatsappWidget extends StatelessWidget {
  const _WhatsappWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(
            'https://api.whatsapp.com/send?phone=77007264066&text=Всем привет!',
          ),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration:
              BoxDecoration(color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            SvgPicture.asset(
              getMainAppTheme(context).icons.whatsapp,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                'Чат дома',
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                'Перейти',
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.activeText),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            SvgPicture.asset(
              getMainAppTheme(context).icons.chevronRight,
              color: getMainAppTheme(context).colors.activeColor,
            )
          ])),
    );
  }
}

class _ManagerWidget extends StatelessWidget {
  const _ManagerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(
            'tel:87007264066',
          ),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration:
              BoxDecoration(color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            SvgPicture.asset(
              getMainAppTheme(context).icons.profile,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Марк Белицкий',
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Управляющий домом',
                  style: getMainAppTheme(context)
                      .textStyles
                      .subBody
                      .copyWith(color: getMainAppTheme(context).colors.inactiveText),
                ),
              ],
            )),
            const SizedBox(
              width: 16,
            ),
            Text(
              'Позвонить',
              style:
                  getMainAppTheme(context).textStyles.body.copyWith(color: getMainAppTheme(context).colors.activeText),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              width: 4,
            ),
            SvgPicture.asset(
              getMainAppTheme(context).icons.chevronRight,
              color: getMainAppTheme(context).colors.activeColor,
            )
          ])),
    );
  }
}
