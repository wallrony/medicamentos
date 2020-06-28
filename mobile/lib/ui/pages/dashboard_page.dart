import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usermedications/ui/animation/FadeAnimation.dart';
import 'package:usermedications/ui/components/custom_text.dart';
import 'package:usermedications/ui/components/medication_list.dart';
import 'package:usermedications/ui//provider/user_provider.dart';
import 'package:usermedications/core/model/medication.dart';
import 'package:usermedications/core/model/user.dart';
import 'package:usermedications/ui/pages/add_medication_page.dart';
import 'package:usermedications/ui/provider/medication_provider.dart';
import 'package:usermedications/ui/views/dashboard/profile_view.dart';
import 'package:usermedications/ui/views/dashboard/home_view.dart';
import 'package:usermedications/ui/pages/login_page.dart';
import 'package:usermedications/ui/services/user_service.dart';
import 'package:usermedications/core/utils/nav_utils.dart';
import 'package:usermedications/core/utils/system_colors.dart';
import 'package:usermedications/core/utils/utils.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> dashboardViews = [HomeView(), ProfileView()];

  bool _menuExtended = false;
  bool _refreshMedications = false;
  bool _medicationEdited = false;

  AnimationController _menuAnimationController;

  @override
  void initState() {
    super.initState();

    _menuAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _getData();

    SystemColors.dashboardColors();
  }

  _getData() async {
    List<String> prefData = await UserService().getUserPrefs();

    Provider.of<UserProvider>(context, listen: false).fetchUser(
      prefData[0],
      int.parse(prefData[1]),
    );

    MedicationProvider medProvider = Provider.of<MedicationProvider>(
      context,
      listen: false,
    );

    await medProvider.fetchMedications(prefData[0], int.parse(prefData[1]));

    final bool haveMedication =
        medProvider.medications != null && medProvider.medications.isNotEmpty;

    SystemColors.dashboardColors(haveMedication: haveMedication);
  }

  _refreshMedicationList() async {
    if (_medicationEdited) {
      closeDialog(context);
      setState(() => _medicationEdited = false);
    }

    List<String> prefData = await UserService().getUserPrefs();

    MedicationProvider medProvider;
    medProvider = Provider.of<MedicationProvider>(context, listen: false);

    await medProvider.refreshMedications(prefData[0], int.parse(prefData[1]));

    _setRefreshList(false);
  }

  @override
  Widget build(BuildContext context) {
    if (_refreshMedications) _refreshMedicationList();

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FadeAnimation(
              1,
              GestureDetector(
                onTap: () => setState(() {
                  _menuAnimationController.reverse();
                  _menuExtended = false;
                }),
                child: dashboardViews[_selectedIndex],
              ),
            ),
            FadeAnimation(
              1,
              Row(
                children: [
                  NavigationRail(
                    extended: _menuExtended,
                    elevation: 3,
                    labelType: NavigationRailLabelType.none,
                    leading: Container(
                      margin: const EdgeInsets.only(left: 13, top: 30),
                      width: 30,
                      child: GestureDetector(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _menuAnimationController,
                          size: !_menuExtended ? 24 : 36,
                        ),
                        onTap: _onMenuTap,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    minWidth: 50,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(
                          Icons.home,
                          size: 24,
                        ),
                        label: CustomText(text: "Medicamentos"),
                        selectedIcon: Icon(
                          Icons.home,
                          size: 30,
                          color: Color.fromRGBO(50, 205, 100, .8),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_pin, size: 24),
                        label: CustomText(text: "Perfil"),
                        selectedIcon: Icon(
                          Icons.person_pin,
                          size: 30,
                          color: Color.fromRGBO(50, 205, 100, .8),
                        ),
                      ),
                    ],
                    trailing: GestureDetector(
                      onTap: _onTapLogout,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 12.5),
                              child: Icon(Icons.exit_to_app),
                            ),
                            _menuExtended
                                ? CustomText(
                                    text: "Sair",
                                    fontSize: 16,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: FadeAnimation(
                1.8,
                Consumer<MedicationProvider>(
                  builder: (context, provider, child) {
                    bool haveMedication = provider.medications != null &&
                        provider.medications.length > 0;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      height: _selectedIndex != 0
                          ? 0
                          : _menuExtended ? 80 : haveMedication ? 230 : 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: haveMedication
                            ? Colors.white
                            : Color.fromRGBO(50, 205, 100, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(24),
                          topRight: const Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: _selectedIndex != 0
                            ? Container()
                            : MedicationList(
                                medProvider: provider,
                                redirectToAddMedication:
                                    _redirectToAddMedication,
                                onItemTap: _onMedicationTap,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setRefreshList(bool value, {bool edited = false}) => setState(() {
        _refreshMedications = value;
        _medicationEdited = edited;
      });

  _onMenuTap() {
    if (_menuExtended)
      _menuAnimationController.reverse();
    else if (!_menuExtended) _menuAnimationController.forward();

    setState(() => _menuExtended = !_menuExtended);
  }

  _onMedicationTap(Medication medication) {
    showCustomDialog(
      context,
      CustomText(
        text: medication.name,
        fontSize: 24,
        isBold: true,
      ),
      medication.description.isNotEmpty
          ? CustomText(
              text: medication.description,
              textAlign: TextAlign.left,
            )
          : null,
      [
        makeActionObject(
          'Editar',
          true,
          () => NavUtils.push(
            context: context,
            page: AddMedicationPage(
              setRefreshList: _setRefreshList,
              edit: true,
              medication: medication,
            ),
          ),
          Icon(Icons.edit),
        ),
        makeActionObject(
          'Deletar',
          true,
          () => deleteMedication(medication.id),
          Icon(Icons.delete_forever),
        ),
        makeActionObject(
          'Fechar',
          true,
          () => closeDialog(context),
          Icon(Icons.close),
        ),
      ],
    );
  }

  deleteMedication(int medId) async {
    closeDialog(context);

    showLoadingDialog(context);

    User user = Provider.of<UserProvider>(context, listen: false).user;

    await Provider.of<MedicationProvider>(context, listen: false)
        .deleteMedication(user.token, user.id, medId);

    closeDialog(context);
  }

  void _redirectToAddMedication() {
    NavUtils.push(
      context: context,
      page: AddMedicationPage(setRefreshList: _setRefreshList),
    );
  }

  void _onTapLogout() async {
    showLoadingDialog(context);

    await Provider.of<UserProvider>(context, listen: false).clearUserPrefData();

    closeDialog(context);

    NavUtils.push(context: context, page: LoginPage(), replace: true);
  }
}
