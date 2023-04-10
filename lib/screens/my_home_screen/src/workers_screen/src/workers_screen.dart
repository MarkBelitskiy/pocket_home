part of '../feature.dart';

class _WorkersScreen extends StatelessWidget {
  const _WorkersScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      floatingActionButton: MainAppFloatingButton(
          enumValue: MainFloatingActionButton.workers,
          onTap: (currentHouse) {
            Navigator.of(context).push(addNewWorkersScreenFeature()).then((value) {
              if (value is WorkerModel) {
                context.read<WorkersBloc>().add(AddWorkerToHouseEvent(value));
              }
            });
          }),
      appBar: const MainAppBar(
        title: 'employees',
        isRoot: true,
      ),
      body: BlocBuilder<WorkersBloc, WorkersState>(
        buildWhen: (previous, current) => current is WorkersLoadedState,
        builder: (context, state) {
          if (state is WorkersLoadedState) {
            if (state.workerModel.isEmpty) {
              return const _EmptyBodyState();
            } else {
              return ListView.builder(
                itemCount: state.workerModel.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    SvgPicture.asset(getMainAppTheme(context).icons.profile),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          state.workerModel[index].fullName,
                          style: getMainAppTheme(context)
                              .textStyles
                              .body
                              .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          state.workerModel[index].phone,
                          style: getMainAppTheme(context)
                              .textStyles
                              .subBody
                              .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
                        )
                      ]),
                    ),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text(
                          state.workerModel[index].jobTitle,
                          style: getMainAppTheme(context)
                              .textStyles
                              .body
                              .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${state.workerModel[index].sallary} ₸',
                          style: getMainAppTheme(context)
                              .textStyles
                              .subBody
                              .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
                        )
                      ]),
                    )
                  ]),
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _EmptyBodyState extends StatelessWidget {
  const _EmptyBodyState();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: EmptyPlaceholderWithLottie(
              lottiePath: getMainAppTheme(context).icons.workersLottie,
              margin: const EdgeInsets.only(bottom: 110, left: 20),
              title: 'haveNoWorkers',
            ),
          ),
        ],
      ),
    );
  }
}
