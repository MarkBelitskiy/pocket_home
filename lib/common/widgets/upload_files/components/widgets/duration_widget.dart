part of '../../feature.dart';

class _DurationWidget extends StatelessWidget {
  const _DurationWidget({Key? key, required this.duration}) : super(key: key);
  final String duration;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons_svg/upload_files_icons/play_arrow.svg',
                color: Colors.white,
                width: 12,
                height: 12,
              ),
              if (duration.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    duration,
                  ),
                )
            ],
          )),
    );
  }
}
