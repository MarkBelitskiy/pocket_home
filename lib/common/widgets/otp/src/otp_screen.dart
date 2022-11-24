part of '../feature.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen(
      {Key? key, required this.phone, required this.continueButtonCallBack})
      : super(key: key);
  final String phone;
  final Function(OtpReturnDataModel) continueButtonCallBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorPalette.darkScreenBackground,
      appBar: _AppBar(),
      body: _Body(
        phone: phone,
        continueButtonCallBack: continueButtonCallBack,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(
      {Key? key, required this.phone, required this.continueButtonCallBack})
      : super(key: key);
  final String phone;
  final Function(OtpReturnDataModel) continueButtonCallBack;
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    FocusNode _focus = FocusNode();
    ValueNotifier<bool> _notifier = ValueNotifier<bool>(false);
    _controller.addListener(() {
      _notifier.value = _controller.text.length == 4;
    });
    String messageId = '';
    return Column(
      children: [
        OtpBi(
            maskedPhone: phone,
            textEditingController: _controller,
            focusNode: _focus),
        // ValueListenableBuilder<bool>(
        //     valueListenable: _notifier,
        //     builder: (context, value, child) {
        //       return Padding(
        //         padding: const EdgeInsets.all(16),
        //         child: BigGradientButton(
        //             isActive: value,
        //             name: getLocale(context)?.continueText ?? '',
        //             func: () {
        //               continueButtonCallBack.call(OtpReturnDataModel(
        //                   phone, messageId, _controller.text));
        //             }),
        //       );
        //     })
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 1.0,
      leadingWidth: 41,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons_svg/close_icon.svg',
          width: 24,
          height: 24,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(''),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class OtpBi extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final bool autoFocus;
  final String maskedPhone;
  OtpBi(
      {Key? key,
      required this.textEditingController,
      required this.focusNode,
      this.autoFocus = true,
      required this.maskedPhone})
      : super(key: key);

  @override
  OtpBiState createState() => OtpBiState();
}

class OtpBiState extends State<OtpBi> {
  final _time = BehaviorSubject<int>.seeded(60);

  Stream<int> get timerSecond => _time.stream;
  Timer? _timer;

  void startTimer() {
    _time.add(60);

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
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
          'На номер, ${maskedPhone.isNotEmpty ? maskedPhone : 'указанный в заявке'} был отправлен SMS код',
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
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        backgroundColor: Colors.transparent,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 62,
          fieldWidth: 48,
          activeFillColor: Colors.white,
          activeColor: Colors.white,
          selectedColor: Colors.white,
          inactiveColor: Colors.white,
          disabledColor: Colors.white,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
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
              )
            : InkWell(
                onTap: () {
                  sendOtpEvent?.call();
                },
                child: Text(
                  'Прислать код повторно',
                  // style: ProjectTextStyle.primary17W400LetterNeg17,
                ),
              );
      },
    );
  }
}
