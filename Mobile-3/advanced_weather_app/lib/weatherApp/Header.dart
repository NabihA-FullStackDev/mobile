import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../api/get_location_from_coordonates.dart';
import '../api/get_location_from_search.dart';
import '../native_functionality/get_position.dart';
import 'models/page_state.dart';

class Header extends AppBar {
  Header({
    Key? key,
    required TextEditingController ctrl,
    required void Function(String) searched,
    required void Function(dynamic) validate,
    required int pageIndex,
    required void Function(int, PageState) pageStater,
  }) : super(
          key: key,
          centerTitle: true,
          backgroundColor:
              const Color.fromARGB(255, 0, 137, 205).withOpacity(0.2),
          title: _buildSearchField(
            ctrl,
            searched,
            validate,
            pageIndex,
            pageStater,
          ),
          actions: [_buildLocationButton(validate, pageIndex, pageStater)],
        );

  static Widget _buildSearchField(
    TextEditingController ctrl,
    void Function(String) searched,
    void Function(dynamic) validate,
    int pageIndex,
    void Function(int, PageState) pageStater,
  ) {
    return TextField(
      controller: ctrl,
      onChanged: (value) {
        searched(value);
      },
      onSubmitted: (value) async {
        pageStater(pageIndex, PageState.loading);
        ctrl.text = "";
        final ret = await getLocationFromSearch(value);
        if (ret != null) {
          validate(ret[0]);
          pageStater(pageIndex, PageState.success);
        } else if (ret == null && value == "") {
          pageStater(pageIndex, PageState.empty);
        } else {
          pageStater(pageIndex, PageState.badLocation);
        }
      },
      decoration: InputDecoration(
        hintText: "Recherche une ville",
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }

  static Widget _buildLocationButton(void Function(dynamic) validate, int page,
      void Function(int, PageState) pageStater) {
    Color primary = Colors.white;

    return IconButton(
      padding: const EdgeInsets.only(right: 12),
      onPressed: () async {
        try {
          pageStater(page, PageState.loading);
          Position position = await getPosition();
          final ret = await getLocationFromCoordonates(
            position.latitude,
            position.longitude,
          );
          if (ret != null) {
            validate(ret);
            pageStater(page, PageState.success);
          } else {
            pageStater(page, PageState.apiFailure);
          }
        } catch (_) {
          pageStater(page, PageState.serviceDenied);
        }
      },
      icon: Icon(
        Icons.location_pin,
        color: primary,
      ),
    );
  }
}
