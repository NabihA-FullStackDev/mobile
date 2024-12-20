import 'package:flutter/material.dart';

import '../api/get_location_from_search.dart';
import 'models/page_state.dart';
import 'views/Currently.dart';
import 'Footer.dart';
import 'Header.dart';
import 'views/Today.dart';
import 'views/Weekly.dart';

class AdvancedWeatherApp extends StatefulWidget {
  const AdvancedWeatherApp({Key? key}) : super(key: key);

  @override
  State<AdvancedWeatherApp> createState() => _AdvancedWeatherAppState();
}

class _AdvancedWeatherAppState extends State<AdvancedWeatherApp> {
  bool _showList = false;
  int _pIndex = 0;
  String _location = "";
  List<dynamic>? _locations = [];
  PageState _cState = PageState.idle;
  PageState _tState = PageState.idle;
  PageState _wState = PageState.idle;
  dynamic currently;
  dynamic today;
  dynamic weekly;

  final PageController _pageController = PageController();
  final TextEditingController _searchCtrl = TextEditingController();

  void _onTabTapped(int index) {
    setState(() {
      _pIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _pIndex = index;
      _searchCtrl.text = "";
    });
  }

  void updateStateByPage(int page, PageState state) {
    switch (page) {
      case 0:
        setState(() {
          _cState = state;
        });
        break;
      case 1:
        setState(() {
          _tState = state;
        });
        break;
      case 2:
        setState(() {
          _wState = state;
        });
        break;
    }
  }

  Future<void> updateSearch(String newLocation) async {
    setState(() {
      _location = newLocation;
    });
    updateStateByPage(_pIndex, PageState.idle);
    final locations = await getLocationFromSearch(_location);
    setState(() {
      _locations = locations;
      _showList = locations != null;
    });
  }

  void updateLocation(dynamic infos) {
    switch (_pIndex) {
      case 0:
        currently = infos;
        break;
      case 1:
        today = infos;
        break;
      case 2:
        weekly = infos;
        break;
    }
    _showList = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.5,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background_center.jpeg'),
              ),
            ),
            child: Column(
              children: [
                Header(
                  ctrl: _searchCtrl,
                  searched: updateSearch,
                  validate: updateLocation,
                  pageIndex: _pIndex,
                  pageStater: updateStateByPage,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      PageView(
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        children: [
                          Currently(
                            infos: currently,
                            state: _cState,
                            updateState: updateStateByPage,
                          ),
                          Today(
                            infos: today,
                            state: _tState,
                            updateState: updateStateByPage,
                          ),
                          Weekly(
                            infos: weekly,
                            state: _wState,
                            updateState: updateStateByPage,
                          ),
                        ],
                      ),
                      if (_locations != null && _showList)
                        _buildSearchResults(),
                    ],
                  ),
                ),
                Footer(
                  currentIndex: _pIndex,
                  onTap: _onTabTapped,
                ),
              ],
            ),
          ),
          if (_cState == PageState.loading ||
              _tState == PageState.loading ||
              _wState == PageState.loading)
            AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withOpacity(0.01),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    Color primary = Colors.white;
    Color backColor = const Color.fromARGB(255, 0, 137, 205).withOpacity(0.3);

    return Positioned(
      left: 0,
      right: 0,
      child: Material(
        color: Colors.white.withOpacity(0.0),
        borderRadius: BorderRadius.circular(16.0),
        elevation: 4.0,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _locations!.length,
          itemBuilder: (context, index) {
            final location = _locations![index];
            return ListTile(
              tileColor: backColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              title: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: location['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                    TextSpan(
                      text: (location['admin1'] != null)
                          ? ", ${location['admin1']}"
                          : "",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: (location['country'] != null)
                          ? ", ${location['country']}"
                          : "",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                updateStateByPage(_pIndex, PageState.loading);
                updateLocation(location);
                _searchCtrl.text = "";
                FocusScope.of(context).unfocus();
                updateStateByPage(_pIndex, PageState.success);
              },
            );
          },
        ),
      ),
    );
  }
}
