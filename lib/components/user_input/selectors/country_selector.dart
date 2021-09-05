import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/model/country.dart';

class SelectedCountryDisplay extends StatelessWidget {
  final String isoCode;
  SelectedCountryDisplay(this.isoCode);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryFlag(isoCode, 26),
        SizedBox(
          width: 10,
        ),
        MyText(CountryRepo.fromIsoCode(isoCode).name),
      ],
    );
  }
}

class CountrySelector extends StatefulWidget {
  final void Function(Country country) selectCountry;
  final Country? selectedCountry;
  CountrySelector({required this.selectCountry, this.selectedCountry});
  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  List<Country> _filteredCountries = CountryRepo.countries;
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.selectedCountry;
  }

  void _handleTextFilterUpdate(String newFilterString) {
    setState(() => {
          _filteredCountries = CountryRepo.countries
              .where((e) =>
                  e.name
                      .toLowerCase()
                      .contains(newFilterString.toLowerCase()) ||
                  e.isoCode
                      .toLowerCase()
                      .contains(newFilterString.toLowerCase()) ||
                  e.iso3Code
                      .toLowerCase()
                      .contains(newFilterString.toLowerCase()))
              .toList()
        });
  }

  void _handleCountrySelect(Country country) {
    setState(() => _selectedCountry = country);
    widget.selectCountry(country);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: MyNavBar(
        automaticallyImplyLeading: false,
        middle: NavBarTitle('Select Country'),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: MyText(
              'Done',
              weight: FontWeight.bold,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: CupertinoSearchTextField(
              onChanged: (text) => _handleTextFilterUpdate(text),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () =>
                          _handleCountrySelect(_filteredCountries[index]),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Styles.grey))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CountryFlag(
                                    _filteredCountries[index].isoCode, 40),
                                SizedBox(width: 12),
                                MyText(
                                  _filteredCountries[index].name,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                            if (_filteredCountries[index] == _selectedCountry)
                              FadeIn(child: ConfirmCheckIcon()),
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
