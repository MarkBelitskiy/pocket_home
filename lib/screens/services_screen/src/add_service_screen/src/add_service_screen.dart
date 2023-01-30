part of '../feature.dart';

class _AddServiceScreen extends StatelessWidget {
  const _AddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        // resizeToAvoidBottomInset: false,
        appBar: const MainAppBar(
          title: 'Создание заявки',
        ),
        body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          const _ChooseProblem(),
          const SizedBox(
            height: 12,
          ),
          const _ContactPerson(),
          const SizedBox(
            height: 12,
          ),
          const _Files(),
          const SizedBox(
            height: 12,
          ),
          const _Commentary(),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: MainAppButton(
                onPressed: () {},
                title: 'Создать',
                assetIcon: '',
                titleColor: ColorPalette.blue200,
              ))
        ],
      ),
    );
  }
}

class _ChooseProblem extends StatelessWidget {
  const _ChooseProblem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Наименование',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: getMainAppTheme(context).colors.cardColor,
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'a',
                  style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                )),
                SvgPicture.asset(
                  getMainAppTheme(context).icons.chevronDown,
                  color: getMainAppTheme(context).colors.activeColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ContactPerson extends StatelessWidget {
  const _ContactPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Контактные данные',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: getMainAppTheme(context).colors.cardColor,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'ФИО',
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
                  Expanded(
                      child: Text(
                    'Белицкий М.И.',
                    textAlign: TextAlign.right,
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Телефон',
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
                  Expanded(
                      child: Text(
                    '+7 777 777 77 77',
                    textAlign: TextAlign.right,
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Редактировать',
                      style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.blue500),
                    )),
                    SvgPicture.asset(
                      getMainAppTheme(context).icons.chevronRight,
                      color: getMainAppTheme(context).colors.activeColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Files extends StatelessWidget {
  const _Files({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Файлы',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 4,
        ),
        MainAppFilePicker(
          maxFiles: 3,
          onFilesAddedCallBack: (files) {},
          isProfilePhotoWidget: false,
        )
      ],
    );
  }
}

class _Commentary extends StatelessWidget {
  const _Commentary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Комментарий',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 4,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 4,
            readOnly: false,
            onChanged: (value) {},
            clearAvailable: true,
            autoFocus: false)
      ],
    );
  }
}
