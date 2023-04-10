part of '../feature.dart';

class _MyHousesScreen extends StatelessWidget {
  const _MyHousesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppThemeViewModel>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: MainAppFloatingButton(
            enumValue: MainFloatingActionButton.myHome,
            onTap: (currentHouse) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  useRootNavigator: true,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                  backgroundColor: getMainAppTheme(context).colors.bgColor,
                  context: context,
                  builder: (modalContext) => _AddHousesModalBody(
                        housesBloc: context.read<MyHousesBloc>(),
                      ));
            }),
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyHousesBloc, MyHousesState>(
      buildWhen: (previous, current) => current is MyHousesLoadedState,
      builder: (context, state) {
        if (state is MyHousesLoadedState) {
          if (state.houses.isEmpty) {
            return const _EmptyBodyState();
          } else {
            return _MyHousesLoaded(
              houses: state.houses,
              activateAnimation: state.activateAnimation,
              currentHouse: state.currentHouse!,
            );
          }
        }
        return const SizedBox.shrink();
      },
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
              lottiePath: getMainAppTheme(context).icons.homeLottie,
              margin: const EdgeInsets.only(bottom: 110, left: 20),
              title: 'haveNotHomes',
            ),
          ),
        ],
      ),
    );
  }
}

class _MyHousesLoaded extends StatelessWidget {
  const _MyHousesLoaded({required this.houses, required this.currentHouse, required this.activateAnimation});
  final List<HouseModel> houses;
  final HouseModel currentHouse;
  final bool activateAnimation;

  @override
  Widget build(BuildContext context) {
    final globalKeys = [GlobalKey(), GlobalKey()];
    final LayerLink layerLink = LayerLink();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        AnimatedOverlayWidget(
          globalKeys,
          layerLink,
        ).showOverlayAnimated(context);
      },
    );
    return Consumer<MainAppThemeViewModel>(
      builder: (context, value, child) => SingleChildScrollView(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 100),
        child: CompositedTransformTarget(
          link: layerLink,
          child: Column(children: [
            const SizedBox(
              height: 64,
            ),
            _ChooseHomeWidget(
              key: globalKeys[0],
              housesModel: houses,
              currentHouse: currentHouse,
            ),
            const SizedBox(
              height: 16,
            ),
            _ManagerWidget(
              key: globalKeys[1],
              manager: currentHouse.manager,
            ),
            const SizedBox(
              height: 16,
            ),
            _WorkersWidget(currentHouse: currentHouse),
            const SizedBox(
              height: 16,
            ),
            _BudgetWidget(
              budget: currentHouse.budget.budgetTotalSum,
            ),
            const SizedBox(
              height: 16,
            ),
            _TelegramWidget(),
            const SizedBox(
              height: 16,
            ),
            _PartnersGrid()
          ]),
        ),
      ),
    );
  }
}

class _ChooseHomeWidget extends StatelessWidget {
  const _ChooseHomeWidget({super.key, required this.housesModel, required this.currentHouse});
  final List<HouseModel> housesModel;
  final HouseModel currentHouse;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            useRootNavigator: true,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            backgroundColor: getMainAppTheme(context).colors.bgColor,
            context: context,
            builder: (modalContext) => _ChangeCurrentChoosenHouseModalBody(
                  housesBloc: context.read<MyHousesBloc>(),
                ));
      },
      child: Container(
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
                  currentHouse.houseNumber,
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context)
                      .textStyles
                      .subBody
                      .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
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
                currentHouse.houseAddress,
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'tenants',
                style: getMainAppTheme(context)
                    .textStyles
                    .subBody
                    .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
              ).plural(120),
            ]),
          ),
          if (housesModel.length > 1) ...[
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              getMainAppTheme(context).icons.chevronDown,
              color: getMainAppTheme(context).colors.activeColor,
            )
          ]
        ]),
      ),
    );
  }
}

class _TelegramWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(
            'https://t.me/+EwFdgFoEWyVjNmIy',
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
              getMainAppTheme(context).icons.telegram,
              width: 32,
              height: 32,
              color: getMainAppTheme(context).colors.activeColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                'houseChat',
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
              ).tr(),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                'followTheLink',
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.activeText),
                textAlign: TextAlign.right,
              ).tr(),
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
  const _ManagerWidget({super.key, required this.manager});
  final Manager manager;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(
            'tel:${manager.phone.replaceAll(' ', '')}',
          ),
          mode: LaunchMode.externalApplication,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration:
            BoxDecoration(color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
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
                    manager.name,
                    style: getMainAppTheme(context)
                        .textStyles
                        .body
                        .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'houseManager',
                    style: getMainAppTheme(context)
                        .textStyles
                        .subBody
                        .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
                  ).tr(),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'call',
              style:
                  getMainAppTheme(context).textStyles.body.copyWith(color: getMainAppTheme(context).colors.activeText),
              textAlign: TextAlign.right,
            ).tr(),
            const SizedBox(
              width: 4,
            ),
            SvgPicture.asset(
              getMainAppTheme(context).icons.chevronRight,
              color: getMainAppTheme(context).colors.activeColor,
            )
          ],
        ),
      ),
    );
  }
}

class _PartnersGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              launchUrl(
                  Uri.parse(index == 0
                      ? 'https://clean-bee.kz/'
                      : "https://mebelplus.kz/kostanai/?ysclid=leb53yj6xy872293380"),
                  mode: LaunchMode.inAppWebView);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(12)),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        index == 0 ? 'Clean\nHome' : "Мебель\nГрад",
                        style: getMainAppTheme(context)
                            .textStyles
                            .title
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      ),
                    ),
                    SvgPicture.asset(
                      index == 0 ? getMainAppTheme(context).icons.cleaning : getMainAppTheme(context).icons.furniture,
                      width: 64,
                      height: 64,
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        index == 0 ? 'cleaningOrder' : 'furnitureOrder',
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.activeText),
                      ).tr(),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      getMainAppTheme(context).icons.chevronRight,
                      color: getMainAppTheme(context).colors.activeColor,
                    )
                  ],
                )
              ]),
            ),
          );
        });
  }
}

class _WorkersWidget extends StatelessWidget {
  const _WorkersWidget({Key? key, required this.currentHouse}) : super(key: key);
  final HouseModel currentHouse;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(workersScreenFeature(currentHouse));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration:
            BoxDecoration(color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            SvgPicture.asset(
              getMainAppTheme(context).icons.workers,
              width: 32,
              color: Colors.white,
              height: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                'employees',
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
              ).tr(),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'followTheLink',
              style:
                  getMainAppTheme(context).textStyles.body.copyWith(color: getMainAppTheme(context).colors.activeText),
              textAlign: TextAlign.right,
            ).tr(),
            const SizedBox(
              width: 4,
            ),
            SvgPicture.asset(
              getMainAppTheme(context).icons.chevronRight,
              color: getMainAppTheme(context).colors.activeColor,
            )
          ],
        ),
      ),
    );
  }
}

class _AddHousesModalBody extends StatelessWidget {
  const _AddHousesModalBody({
    required this.housesBloc,
  });

  final MyHousesBloc housesBloc;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    FocusNode focus = FocusNode();
    return BlocProvider.value(
      value: housesBloc..add(GetHousesToModalEvent()),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
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
                    'addHouse',
                    textAlign: TextAlign.center,
                    style: getMainAppTheme(context)
                        .textStyles
                        .body
                        .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
                  ).tr(),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: SvgPicture.asset(
                      getMainAppTheme(context).icons.close,
                      color: getMainAppTheme(context).colors.textOnBgColor,
                    ))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            BlocBuilder<MyHousesBloc, MyHousesState>(
                buildWhen: (previous, current) => current is ReturnedHouseseToAddHouseModal,
                builder: (context, state) {
                  if (state is ReturnedHouseseToAddHouseModal) {
                    return Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 50),
                            child: MainTextField(
                              prefixIcon: getMainAppTheme(context).icons.search,
                              textController: controller,
                              focusNode: focus,
                              title: 'search',
                              onChanged: (value) {
                                housesBloc.add(FilteredHousesToModalEvent(value));
                              },
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: ListView.separated(
                                padding: const EdgeInsets.only(bottom: 12),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: state.houses.length,
                                itemBuilder: (context, index) {
                                  final HouseModel item = state.houses[index];
                                  return GestureDetector(
                                      onTap: () {
                                        housesBloc.add(AddHouseToMyHouseseEvent(item));
                                        Navigator.of(context).pop();
                                      },
                                      child: _HouseWidget(house: item));
                                }),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class _HouseWidget extends StatelessWidget {
  const _HouseWidget({required this.house});
  final HouseModel house;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: getMainAppTheme(context).colors.cardColor,
      ),
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
                house.houseNumber,
                textAlign: TextAlign.center,
                style: getMainAppTheme(context)
                    .textStyles
                    .subBody
                    .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
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
              house.houseAddress,
              style: getMainAppTheme(context)
                  .textStyles
                  .body
                  .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'tenants',
              style: getMainAppTheme(context)
                  .textStyles
                  .subBody
                  .copyWith(color: getMainAppTheme(context).colors.inactiveText),
            ).plural(120),
          ]),
        ),
        const SizedBox(
          width: 8,
        ),
        SvgPicture.asset(
          getMainAppTheme(context).icons.chevronRight,
          color: getMainAppTheme(context).colors.activeColor,
        )
      ]),
    );
  }
}

class _ChangeCurrentChoosenHouseModalBody extends StatelessWidget {
  const _ChangeCurrentChoosenHouseModalBody({required this.housesBloc});
  final MyHousesBloc housesBloc;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    FocusNode focus = FocusNode();
    return BlocProvider.value(
      value: housesBloc..add(FilteredHousesToChangeHouseModalEvent('')),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
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
                    'changeHouse',
                    textAlign: TextAlign.center,
                    style: getMainAppTheme(context)
                        .textStyles
                        .body
                        .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
            BlocBuilder<MyHousesBloc, MyHousesState>(
                buildWhen: (previous, current) => current is ReturnedHouseseToChangeHouseModal,
                builder: (context, state) {
                  if (state is ReturnedHouseseToChangeHouseModal) {
                    return Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 50),
                            child: MainTextField(
                              prefixIcon: getMainAppTheme(context).icons.search,
                              textController: controller,
                              focusNode: focus,
                              title: 'search',
                              onChanged: (value) {
                                housesBloc.add(FilteredHousesToChangeHouseModalEvent(value));
                              },
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: ListView.separated(
                                padding: const EdgeInsets.only(bottom: 12),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: state.houses.length,
                                itemBuilder: (context, index) {
                                  final HouseModel item = state.houses[index];
                                  return GestureDetector(
                                      onTap: () {
                                        housesBloc.add(ChangeCurrentHomeEvent(item));
                                        Navigator.of(context).pop();
                                      },
                                      child: _HouseWidget(house: item));
                                }),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class _BudgetWidget extends StatelessWidget {
  const _BudgetWidget({required this.budget});
  final int budget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(
          Uri.parse(
            'https://kaspi.kz',
          ),
          mode: LaunchMode.externalApplication,
        ).then((value) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            context.read<MyHousesBloc>().add(AddPaymentToBudget(20000));
          });
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration:
            BoxDecoration(color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            SvgPicture.asset(
              getMainAppTheme(context).icons.money,
              width: 32,
              height: 32,
              color: getMainAppTheme(context).colors.successColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$budget ₸',
                    style: getMainAppTheme(context)
                        .textStyles
                        .body
                        .copyWith(color: getMainAppTheme(context).colors.successColor),
                  ),
                  Text(
                    'houseBudget',
                    style: getMainAppTheme(context)
                        .textStyles
                        .subBody
                        .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
                  ).tr(),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                'fillBalance',
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.activeText),
                textAlign: TextAlign.right,
              ).tr(),
            ),
            const SizedBox(
              width: 4,
            ),
            SvgPicture.asset(
              getMainAppTheme(context).icons.chevronRight,
              color: getMainAppTheme(context).colors.activeColor,
            )
          ],
        ),
      ),
    );
  }
}
