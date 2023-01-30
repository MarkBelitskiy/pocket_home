part of '../feature.dart';

class _AddNewsScreen extends StatelessWidget {
  const _AddNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: MainAppBar(
          title: 'createNews'.tr(),
        ),
        body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MainAppBody(
        isDoubleBlob: true,
        children: [
          const _PickTypeWidget(),
          const SizedBox(
            height: 24,
          ),
          BlocConsumer<AddNewsBloc, AddNewsState>(
              listener: (context, state) {
                if (state is NewsAddedSuccessState) {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                      backgroundColor: getMainAppTheme(context).colors.bgColor,
                      context: context,
                      builder: (context) => _ModalBody()).then((value) {
                    Navigator.of(context).pop(true);
                  });
                }
              },
              buildWhen: (previous, current) =>
                  current is NewsBodyState || current is PollsBodyState,
              builder: (context, state) {
                if (state is NewsBodyState) {
                  return const _NewsBody();
                }
                if (state is PollsBodyState) {
                  return const _PollsBody();
                }
                return const SizedBox.shrink();
              }),
        ],
      ),
    );
  }
}

class _PickTypeWidget extends StatefulWidget {
  const _PickTypeWidget({super.key});

  @override
  State<_PickTypeWidget> createState() => _PickTypeWidgetState();
}

class _PickTypeWidgetState extends State<_PickTypeWidget> {
  String title = 'publishType'.tr();
  final List<String> items = ['Новости', 'Опросы'];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          showMainAppBottomSheet(context, title: 'Выберите тип', items: items)
              .then((value) {
        if (value is int) {
          context.read<AddNewsBloc>().add(ChangeBodyEvent(value));
          setState(() {
            title = items[value];
          });
        }
      }),
      child: Container(
        decoration: BoxDecoration(
            color: getMainAppTheme(context).colors.cardColor,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: getMainAppTheme(context).textStyles.body.copyWith(
                  color: getMainAppTheme(context).colors.inactiveText),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          SvgPicture.asset(
            getMainAppTheme(context).icons.chevronDown,
            width: 24,
            height: 24,
            color: getMainAppTheme(context).colors.activeColor,
          ),
        ]),
      ),
    );
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    String title = '';

    String newsText = '';

    String filePath = '';
    return Column(
      children: [
        MainAppFilePicker(
          maxFiles: 1,
          onFilesAddedCallBack: (filesPath) {
            filePath = filesPath.isNotEmpty ? filesPath[0] : '';
          },
        ),
        const SizedBox(
          height: 24,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 1,
            title: 'header'.tr(),
            readOnly: false,
            onChanged: (value) {
              title = value;
            },
            clearAvailable: true,
            autoFocus: false),
        const SizedBox(
          height: 24,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 5,
            title: 'newsText'.tr(),
            readOnly: false,
            onChanged: (value) {
              newsText = value;
            },
            clearAvailable: true,
            autoFocus: false),
        const SizedBox(
          height: 48,
        ),
        MainAppButton(
            titleColor: getMainAppTheme(context).colors.activeText,
            onPressed: () {
              context.read<AddNewsBloc>().add(CreateNewsEvent(
                    model: NewsModel(
                        filePath: filePath,
                        newsText: newsText,
                        choosenPollValue: null,
                        newsTitle: title,
                        pollAnswers: null,
                        publishDate: DateTime.now()),
                  ));
            },
            title: 'publish'.tr(),
            assetIcon: ''),
      ],
    );
  }
}

class _PollsBody extends StatelessWidget {
  const _PollsBody({super.key});

  @override
  Widget build(BuildContext context) {
    String title = '';

    List<String> pollAnswers = [];

    return Column(
      children: [
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 1,
            title: 'header'.tr(),
            readOnly: false,
            onChanged: (value) {
              title = value;
            },
            clearAvailable: true,
            autoFocus: false),
        const SizedBox(
          height: 24,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 1,
            title: 'Вариант ответа 1',
            readOnly: false,
            onChanged: (value) {
              pollAnswers.add(value);
            },
            clearAvailable: true,
            autoFocus: false),
        const SizedBox(
          height: 24,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 1,
            title: 'Вариант ответа 2',
            readOnly: false,
            onChanged: (value) {
              pollAnswers.add(value);
            },
            clearAvailable: true,
            autoFocus: false),
        const SizedBox(
          height: 24,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 1,
            title: 'Вариант ответа 3',
            readOnly: false,
            onChanged: (value) {
              pollAnswers.add(value);
            },
            clearAvailable: true,
            autoFocus: false),
        const SizedBox(
          height: 24,
        ),
        MainAppButton(
            titleColor: getMainAppTheme(context).colors.activeText,
            onPressed: () {
              context.read<AddNewsBloc>().add(CreateNewsEvent(
                    model: NewsModel(
                        filePath: '',
                        newsText: '',
                        newsTitle: title,
                        pollAnswers: pollAnswers,
                        choosenPollValue: null,
                        publishDate: DateTime.now()),
                  ));
            },
            title: 'publish'.tr(),
            assetIcon: ''),
      ],
    );
  }
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Text(
                'Новость успешно создана',
                textAlign: TextAlign.center,
                style: getMainAppTheme(context).textStyles.body.copyWith(
                    color: getMainAppTheme(context).colors.mainTextColor),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: SvgPicture.asset(
                  getMainAppTheme(context).icons.close,
                  color: getMainAppTheme(context).colors.mainTextColor,
                ))
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        SvgPicture.asset(getMainAppTheme(context).icons.actionSuccess),
        Padding(
          padding: const EdgeInsets.all(24),
          child: MainAppButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              title: 'Закрыть',
              assetIcon: ''),
        )
      ],
    );
  }
}
