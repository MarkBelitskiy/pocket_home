part of '../feature.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key, required this.phone, required this.continueButtonCallBack}) : super(key: key);
  final String phone;
  final Function(OtpReturnDataModel) continueButtonCallBack;
  @override
  Widget build(BuildContext context) {
    NotificationService service = NotificationService();
    service.showNotificationWithoutSound();
    TextEditingController _controller = TextEditingController();
    FocusNode _focus = FocusNode();
    ValueNotifier<bool> _notifier = ValueNotifier<bool>(false);
    _controller.addListener(() {
      _notifier.value = _controller.text.length == 4;
    });
    String messageId = '';
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: const MainAppBar(title: 'Восстановление пароля'),
        body: MainAppBody(
          isDoubleBlob: false,
          children: [
            Column(
              children: [
                OtpWidget(maskedPhone: phone, textEditingController: _controller, focusNode: _focus),
                const SizedBox(
                  height: 80,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: _notifier,
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: MainAppButton(
                          title: 'Продолжить',
                          onPressed: () {
                            continueButtonCallBack.call(OtpReturnDataModel(phone, messageId, _controller.text));
                          },
                          assetIcon: '',
                        ),
                      );
                    })
              ],
            )
          ],
        ));
  }
}

class OtpWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final bool autoFocus;
  final String maskedPhone;
  OtpWidget(
      {Key? key,
      required this.textEditingController,
      required this.focusNode,
      this.autoFocus = true,
      required this.maskedPhone})
      : super(key: key);

  @override
  OtpWidgetState createState() => OtpWidgetState();
}

class OtpWidgetState extends State<OtpWidget> {
  final _time = BehaviorSubject<int>.seeded(60);

  Stream<int> get timerSecond => _time.stream;
  Timer? _timer;

  void startTimer() {
    _time.add(60);

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_time.value < 1) {
        _timer?.cancel();
        _time.add(0);
      } else {
        _time.add(--_time.value);
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _time.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String _phone =
    // '${FormatsTheme().newMask.maskText(widget.maskedPhone.replaceFirst(RegExp(r"^8"), "+7"))}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // _InfoText(
          // maskedPhone: _phone,
          // ),
          const SizedBox(height: 16),
          _PinCodeField(
            textEditingController: widget.textEditingController,
            focusNode: widget.focusNode,
            fieldsCount: 4,
          ),
          const SizedBox(height: 15),
          _ResendSMS(
            timerStream: timerSecond,
            sendOtpEvent: () {
              startTimer();
            },
          ),
        ],
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText({Key? key, required this.maskedPhone}) : super(key: key);
  final String maskedPhone;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          'На номер, $maskedPhone был отправлен SMS код',
          // style: ProjectTextStyle.black15W400LetterNeg17Opacity5,
        ),
      ),
    );
  }
}

class _PinCodeField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final int fieldsCount;

  const _PinCodeField({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
    required this.fieldsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldsCount * 53.0,
      child: PinCodeTextField(
        appContext: context,
        validator: (value) {
          if ((value ?? '').length < fieldsCount) {
            return "Заполните код полностью";
          } else {
            return null;
          }
        },
        focusNode: focusNode,
        controller: textEditingController,
        autoFocus: true,
        length: fieldsCount,
        autoDismissKeyboard: false,
        keyboardType: TextInputType.number,
        animationType: AnimationType.fade,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        backgroundColor: Colors.transparent,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 62,
          fieldWidth: 48,
          activeFillColor: getMainAppTheme(context).colors.cardColor,
          activeColor: getMainAppTheme(context).colors.cardColor,
          selectedColor: getMainAppTheme(context).colors.cardColor,
          inactiveColor: getMainAppTheme(context).colors.cardColor,
          disabledColor: getMainAppTheme(context).colors.cardColor,
          selectedFillColor: getMainAppTheme(context).colors.cardColor,
          inactiveFillColor: getMainAppTheme(context).colors.cardColor,
        ),
        onChanged: (value) {
          debugPrint(value);
        },
      ),
    );
  }
}

class _ResendSMS extends StatelessWidget {
  final Stream<int> timerStream;
  final Function? sendOtpEvent;
  const _ResendSMS({
    Key? key,
    required this.timerStream,
    required this.sendOtpEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 60,
      stream: timerStream,
      builder: (context, snapshot) {
        return (snapshot.data ?? 0) > 0
            ? Text(
                'Прислать код повторно через: ${snapshot.data}',
                // style: ProjectTextStyle.black15W400LetterNeg17Opacity5,
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
              )
            : InkWell(
                onTap: () {
                  sendOtpEvent?.call();
                },
                child: Text(
                  'Прислать код повторно',
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.activeColor),
                ),
              );
      },
    );
  }
}
