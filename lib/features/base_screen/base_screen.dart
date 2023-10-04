import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mesto_flutter/constants/theme_colors.dart';
import 'package:mesto_flutter/di/service_locator.dart';
import 'package:mesto_flutter/features/auth/bloc/auth_bloc.dart';

abstract class BasePageScreen extends StatefulWidget {
  const BasePageScreen({Key? key}) : super(key: key);
}

abstract class BasePageScreenState<T extends BasePageScreen> extends State<T> {
  bool _isBack = false;
  String _backUrl = '';
  Widget? _backButtonIcon;
  bool _isShowTitle = true;
  bool _isElevation = true;
  bool _isHeader = false;
  final TextEditingController _searchTextController = TextEditingController();
  bool _isShowAppBar = true;
  Widget? _action;

  Color? _scaffoldBackgroundColor;

  final StreamController _loadingController = StreamController<bool>();
  final StreamController _titleController = StreamController<String>();

  String appBarTitle();

  void onClickBackButton() {
    if (_backUrl != '') {
      context.go(_backUrl);
    } else {
      context.pop();
    }
  }

  void isBackButton(bool isBack, [String? backUrl]) {
    _isBack = isBack;
    _backUrl = backUrl ?? '';
  }

  void backButtonIcon(Icon backButtonIcon) {
    _backButtonIcon = backButtonIcon;
  }

  void isShowTitle(bool isShowTitle) {
    _isShowTitle = isShowTitle;
  }

  void isShowAppBar(bool isShowAppBar) {
    _isShowAppBar = isShowAppBar;
  }

  void isElevation(bool isElevation) {
    _isElevation = isElevation;
  }

  void isHeader(bool isHeader, [bool isSearch = false]) {
    _isHeader = isHeader;
  }

  void setScaffoldBackgroundColor(Color scaffoldBackgroundColor) {
    _scaffoldBackgroundColor = scaffoldBackgroundColor;
  }

  void showLoading() {
    _loadingController.add(true);
  }

  void hideLoading() {
    _loadingController.add(false);
  }

  void changeTitle(String title) {
    _titleController.add(title);
  }

  void changeAction(Widget action) {
    _action = action;
  }

  void setSearchQuery(String query) {
    _searchTextController.text = query;
    _searchTextController.selection =
        TextSelection.collapsed(offset: _searchTextController.text.length);
  }
}

mixin BaseScreen<T extends BasePageScreen> on BasePageScreenState<T> {
  DateTime? currentBackPressTime;
  bool isShell = false;
  final _authBloc = getIt<AuthBloc>();

  @override
  void initState() {
    isShell = GoRouter.of(context)
        .routeInformationParser
        .configuration
        .routes
        .toString()
        .contains('shell');

    super.initState();
  }

  @override
  void dispose() {
    _loadingController.close();
    _titleController.close();
    super.dispose();
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(
        color: ThemeColors.primary,
        strokeWidth: 3,
      ),
    );
  }

  Widget body();

  List<Widget> actions() => _action != null ? [_action!] : [];

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if ((currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) &&
        !context.canPop()) {
      currentBackPressTime = now;
      // TODO: подключить текст из локализаций
      Fluttertoast.showToast(msg: 'Для выхода нажмите еще раз');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: _scaffoldBackgroundColor ??
            Theme.of(context).scaffoldBackgroundColor,
        appBar: _isShowAppBar
            ? PreferredSize(
                preferredSize: Size.fromHeight(_isHeader ? 91 : 40),
                child: Container(
                  decoration: BoxDecoration(
                    border: _isElevation
                        ? const Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(26, 26, 29, 0.1)),
                          )
                        : null,
                    boxShadow: _isElevation
                        ? [
                            const BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                              blurRadius: 6.0,
                              offset: Offset(0, 6.0),
                            )
                          ]
                        : null,
                  ),
                  child: AppBar(
                    centerTitle: false,
                    titleSpacing: _isBack ? 0 : null,
                    elevation: 0,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: _isShowTitle,
                          child: StreamBuilder(
                            stream: _titleController.stream,
                            builder: (_, snapshot) {
                              return !_isBack
                                  ? Text(
                                      snapshot.data != null
                                          ? snapshot.data.toString()
                                          : appBarTitle(),
                                    )
                                  : Text(
                                      snapshot.data != null
                                          ? snapshot.data.toString()
                                          : appBarTitle(),
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                    leadingWidth: _isBack ? 40 : null,
                    leading: _isBack
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: IconButton(
                              splashRadius: 20,
                              padding: EdgeInsets.zero,
                              icon: _backButtonIcon ??
                                  Icon(
                                    Icons.arrow_left,
                                    size: 20.0,
                                    color: ThemeColors.black60,
                                  ),
                              onPressed: () {
                                onClickBackButton();
                              },
                            ),
                          )
                        : null,
                    actions: actions(),
                    bottom: _isHeader
                        ? const PreferredSize(
                            preferredSize: Size.fromHeight(91),
                            child: SizedBox(),
                          )
                        : null,
                  ),
                ),
              )
            : null,
        body: BlocListener<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is UserLogoutState) {
              context.go('/auth');
            }
          },
          child: WillPopScope(
            onWillPop: Platform.isIOS ? null : onWillPop,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    child: body(),
                  ),
                ),
                StreamBuilder(
                  stream: _loadingController.stream,
                  builder: (_, snapshot) {
                    return snapshot.data == true
                        ? Positioned.fill(child: _buildLoader())
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
