part of '../../feature.dart';

class _PermissionRequestDialog extends StatelessWidget {
  final Permission permission;

  const _PermissionRequestDialog({Key? key, required this.permission})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 38),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons_svg/alerts/ic_warning.svg'),
            const SizedBox(height: 10),
            Text(
              _getText(permission),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () async => await openAppSettings(),
              child: Container(
                padding: EdgeInsets.all(14),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.1, 0.7, 0.9],
                    colors: [
                      const Color(0xff2466A2),
                      const Color(0xff70CCDD),
                      const Color(0xff70AFDD),
                    ],
                    tileMode: TileMode.repeated,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Настройки',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
                onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                child: Container(
                    padding: EdgeInsets.all(14),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: Text(
                      'Отмена',
                      textAlign: TextAlign.center,
                    ))),
          ],
        ),
      ),
    );
  }

  String _getText(Permission permission) {
    String text = "Разрешите доступ приложению";
    if (permission == Permission.camera) {
      text =
          'Разрешите доступ к камере в настройках устройства, для корректной работы приложения';
    }
    if (permission == Permission.photos) {
      text =
          'Разрешите доступ к галереи в настройках устройства, для корректной работы приложения';
    }
    if (permission == Permission.microphone) {
      text =
          'Разрешите доступ к микрофону в настройках устройства, для корректной работы приложения';
    }
    if (permission == Permission.storage) {
      text =
          'Разрешите доступ к файловой системе в настройках устройства, для корректной работы приложения';
    }
    return text;
  }
}
