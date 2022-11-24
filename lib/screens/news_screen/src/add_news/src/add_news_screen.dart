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
          _PickTypeWidget(),
          const SizedBox(
            height: 24,
          ),
          UploadFilesWidget(
            storageTypes: [STORAGE_TYPE.GALLERY, STORAGE_TYPE.CAMERA],
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
              onChanged: (value) {},
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
              onChanged: (value) {},
              clearAvailable: true,
              autoFocus: false),
          const SizedBox(
            height: 48,
          ),
          MainAppButton(
              titleColor: getMainAppTheme(context).colors.activeText,
              onPressed: () {},
              title: 'publish'.tr(),
              assetIcon: ''),
        ],
      ),
    );
  }
}

class _PickTypeWidget extends StatelessWidget {
  const _PickTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showMainAppBottomSheet(context,
          title: 'Выберите тип', items: ['Новости', 'Опросы']),
      child: Container(
        decoration: BoxDecoration(
            color: getMainAppTheme(context).colors.cardColor,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Expanded(
            child: Text(
              'publishType'.tr(),
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
