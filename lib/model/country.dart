import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Country extends Equatable {
  final String isoCode;
  final String phoneCode;
  final String name;
  final String iso3Code;

  const Country({
    required this.isoCode,
    required this.phoneCode,
    required this.name,
    required this.iso3Code,
  });

  factory Country.fromIsoCode(String isoCode) {
    final Country country = CountryRepo.countries.firstWhere(
        (country) => country.isoCode == isoCode,
        orElse: () => throw Exception('You supplied an unknown isoCode.'));

    return country;
  }

  @override
  String toString() => "$isoCode: $name";

  @override
  List<Object> get props => [
        isoCode,
        phoneCode,
        name,
        iso3Code,
      ];
}

class CountryFlag extends StatelessWidget {
  final String isoCode;
  final double size;
  const CountryFlag(this.isoCode, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
              color: CupertinoColors.black.withOpacity(0.3),
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 0.5, //extend the shadow
              offset: const Offset(
                0.5, // Move to right horizontally
                0.5, // Move to bottom Vertically
              )),
        ],
      ),
      child: Image.asset('assets/flags/png/${isoCode.toLowerCase()}.png',
          width: size),
    );
  }
}

class CountryRepo {
  static Country fromIsoCode(String isoCode) =>
      countries.firstWhere((country) => country.isoCode == isoCode,
          orElse: () => throw Exception('You supplied an unknown isoCode.'));

  static final List<Country> countries = [
    const Country(
      isoCode: "AF",
      phoneCode: "93",
      name: "Afghanistan",
      iso3Code: "AFG",
    ),
    const Country(
      isoCode: "AL",
      phoneCode: "355",
      name: "Albania",
      iso3Code: "ALB",
    ),
    const Country(
      isoCode: "DZ",
      phoneCode: "213",
      name: "Algeria",
      iso3Code: "DZA",
    ),
    const Country(
      isoCode: "AS",
      phoneCode: "1-684",
      name: "American Samoa",
      iso3Code: "ASM",
    ),
    const Country(
      isoCode: "AD",
      phoneCode: "376",
      name: "Andorra",
      iso3Code: "AND",
    ),
    const Country(
      isoCode: "AO",
      phoneCode: "244",
      name: "Angola",
      iso3Code: "AGO",
    ),
    const Country(
      isoCode: "AI",
      phoneCode: "1-264",
      name: "Anguilla",
      iso3Code: "AIA",
    ),
    const Country(
      isoCode: "AQ",
      phoneCode: "672",
      name: "Antarctica",
      iso3Code: "ATA",
    ),
    const Country(
      isoCode: "AG",
      phoneCode: "1-268",
      name: "Antigua and Barbuda",
      iso3Code: "ATG",
    ),
    const Country(
      isoCode: "AR",
      phoneCode: "54",
      name: "Argentina",
      iso3Code: "ARG",
    ),
    const Country(
      isoCode: "AM",
      phoneCode: "374",
      name: "Armenia",
      iso3Code: "ARM",
    ),
    const Country(
      isoCode: "AW",
      phoneCode: "297",
      name: "Aruba",
      iso3Code: "ABW",
    ),
    const Country(
      isoCode: "AU",
      phoneCode: "61",
      name: "Australia",
      iso3Code: "AUS",
    ),
    const Country(
      isoCode: "AT",
      phoneCode: "43",
      name: "Austria",
      iso3Code: "AUT",
    ),
    const Country(
      isoCode: "AZ",
      phoneCode: "994",
      name: "Azerbaijan",
      iso3Code: "AZE",
    ),
    const Country(
      isoCode: "BS",
      phoneCode: "1-242",
      name: "Bahamas",
      iso3Code: "BHS",
    ),
    const Country(
      isoCode: "BH",
      phoneCode: "973",
      name: "Bahrain",
      iso3Code: "BHR",
    ),
    const Country(
      isoCode: "BD",
      phoneCode: "880",
      name: "Bangladesh",
      iso3Code: "BGD",
    ),
    const Country(
      isoCode: "BB",
      phoneCode: "1-246",
      name: "Barbados",
      iso3Code: "BRB",
    ),
    const Country(
      isoCode: "BY",
      phoneCode: "375",
      name: "Belarus",
      iso3Code: "BLR",
    ),
    const Country(
      isoCode: "BE",
      phoneCode: "32",
      name: "Belgium",
      iso3Code: "BEL",
    ),
    const Country(
      isoCode: "BZ",
      phoneCode: "501",
      name: "Belize",
      iso3Code: "BLZ",
    ),
    const Country(
      isoCode: "BJ",
      phoneCode: "229",
      name: "Benin",
      iso3Code: "BEN",
    ),
    const Country(
      isoCode: "BM",
      phoneCode: "1-441",
      name: "Bermuda",
      iso3Code: "BMU",
    ),
    const Country(
      isoCode: "BT",
      phoneCode: "975",
      name: "Bhutan",
      iso3Code: "BTN",
    ),
    const Country(
      isoCode: "BO",
      phoneCode: "591",
      name: "Bolivia",
      iso3Code: "BOL",
    ),
    const Country(
      isoCode: "BA",
      phoneCode: "387",
      name: "Bosnia and Herzegovina",
      iso3Code: "BIH",
    ),
    const Country(
      isoCode: "BW",
      phoneCode: "267",
      name: "Botswana",
      iso3Code: "BWA",
    ),
    const Country(
      isoCode: "BV",
      phoneCode: "47",
      name: "Bouvet Island",
      iso3Code: "BVT",
    ),
    const Country(
      isoCode: "BR",
      phoneCode: "55",
      name: "Brazil",
      iso3Code: "BRA",
    ),
    const Country(
      isoCode: "IO",
      phoneCode: "246",
      name: "British Indian Ocean Territory",
      iso3Code: "IOT",
    ),
    const Country(
      isoCode: "BN",
      phoneCode: "673",
      name: "Brunei Darussalam",
      iso3Code: "BRN",
    ),
    const Country(
      isoCode: "BG",
      phoneCode: "359",
      name: "Bulgaria",
      iso3Code: "BGR",
    ),
    const Country(
      isoCode: "BF",
      phoneCode: "226",
      name: "Burkina Faso",
      iso3Code: "BFA",
    ),
    const Country(
      isoCode: "BI",
      phoneCode: "257",
      name: "Burundi",
      iso3Code: "BDI",
    ),
    const Country(
      isoCode: "KH",
      phoneCode: "855",
      name: "Cambodia",
      iso3Code: "KHM",
    ),
    const Country(
      isoCode: "CM",
      phoneCode: "237",
      name: "Cameroon",
      iso3Code: "CMR",
    ),
    const Country(
      isoCode: "CA",
      phoneCode: "1",
      name: "Canada",
      iso3Code: "CAN",
    ),
    const Country(
      isoCode: "CV",
      phoneCode: "238",
      name: "Cape Verde",
      iso3Code: "CPV",
    ),
    const Country(
      isoCode: "BQ",
      phoneCode: "599",
      name: "Caribbean Netherlands",
      iso3Code: "BES",
    ),
    const Country(
      isoCode: "KY",
      phoneCode: "1-345",
      name: "Cayman Islands",
      iso3Code: "CYM",
    ),
    const Country(
      isoCode: "CF",
      phoneCode: "236",
      name: "Central African Republic",
      iso3Code: "CAF",
    ),
    const Country(
      isoCode: "TD",
      phoneCode: "235",
      name: "Chad",
      iso3Code: "TCD",
    ),
    const Country(
      isoCode: "CL",
      phoneCode: "56",
      name: "Chile",
      iso3Code: "CHL",
    ),
    const Country(
      isoCode: "CN",
      phoneCode: "86",
      name: "China",
      iso3Code: "CHN",
    ),
    const Country(
      isoCode: "CX",
      phoneCode: "61",
      name: "Christmas Island",
      iso3Code: "CXR",
    ),
    const Country(
      isoCode: "CC",
      phoneCode: "61",
      name: "Cocos (Keeling) Islands",
      iso3Code: "CCK",
    ),
    const Country(
      isoCode: "CO",
      phoneCode: "57",
      name: "Colombia",
      iso3Code: "COL",
    ),
    const Country(
      isoCode: "KM",
      phoneCode: "269",
      name: "Comoros",
      iso3Code: "COM",
    ),
    const Country(
      isoCode: "CG",
      phoneCode: "242",
      name: "Congo",
      iso3Code: "COG",
    ),
    const Country(
      isoCode: "CD",
      phoneCode: "243",
      name: "Congo, the Democratic Republic",
      iso3Code: "COD",
    ),
    const Country(
      isoCode: "CK",
      phoneCode: "682",
      name: "Cook Islands",
      iso3Code: "COK",
    ),
    const Country(
      isoCode: "CR",
      phoneCode: "506",
      name: "Costa Rica",
      iso3Code: "CRI",
    ),
    const Country(
      isoCode: "HR",
      phoneCode: "385",
      name: "Croatia",
      iso3Code: "HRV",
    ),
    const Country(
      isoCode: "CU",
      phoneCode: "53",
      name: "Cuba",
      iso3Code: "CUB",
    ),
    const Country(
      isoCode: "CW",
      phoneCode: "599",
      name: "Curaçao",
      iso3Code: "CUW",
    ),
    const Country(
      isoCode: "CY",
      phoneCode: "357",
      name: "Cyprus",
      iso3Code: "CYP",
    ),
    const Country(
      isoCode: "CZ",
      phoneCode: "420",
      name: "Czech Republic",
      iso3Code: "CZE",
    ),
    const Country(
      isoCode: "CI",
      phoneCode: "225",
      name: "Côte d'Ivoire",
      iso3Code: "CIV",
    ),
    const Country(
      isoCode: "DK",
      phoneCode: "45",
      name: "Denmark",
      iso3Code: "DNK",
    ),
    const Country(
      isoCode: "DJ",
      phoneCode: "253",
      name: "Djibouti",
      iso3Code: "DJI",
    ),
    const Country(
      isoCode: "DM",
      phoneCode: "1-767",
      name: "Dominica",
      iso3Code: "DMA",
    ),
    const Country(
      isoCode: "DO",
      phoneCode: "1-849",
      name: "Dominican Republic",
      iso3Code: "DOM",
    ),
    const Country(
      isoCode: "EC",
      phoneCode: "593",
      name: "Ecuador",
      iso3Code: "ECU",
    ),
    const Country(
      isoCode: "EG",
      phoneCode: "20",
      name: "Egypt",
      iso3Code: "EGY",
    ),
    const Country(
      isoCode: "SV",
      phoneCode: "503",
      name: "El Salvador",
      iso3Code: "SLV",
    ),
    const Country(
      isoCode: "GB-ENG",
      phoneCode: "44",
      name: "England",
      iso3Code: "GBR",
    ),
    const Country(
      isoCode: "GQ",
      phoneCode: "240",
      name: "Equatorial Guinea",
      iso3Code: "GNQ",
    ),
    const Country(
      isoCode: "ER",
      phoneCode: "291",
      name: "Eritrea",
      iso3Code: "ERI",
    ),
    const Country(
      isoCode: "EE",
      phoneCode: "372",
      name: "Estonia",
      iso3Code: "EST",
    ),
    const Country(
      isoCode: "ET",
      phoneCode: "251",
      name: "Ethiopia",
      iso3Code: "ETH",
    ),
    const Country(
      isoCode: "FK",
      phoneCode: "500",
      name: "Falkland Islands (Malvinas)",
      iso3Code: "FLK",
    ),
    const Country(
      isoCode: "FO",
      phoneCode: "298",
      name: "Faroe Islands",
      iso3Code: "FRO",
    ),
    const Country(
      isoCode: "FJ",
      phoneCode: "679",
      name: "Fiji",
      iso3Code: "FJI",
    ),
    const Country(
      isoCode: "FI",
      phoneCode: "358",
      name: "Finland",
      iso3Code: "FIN",
    ),
    const Country(
      isoCode: "FR",
      phoneCode: "33",
      name: "France",
      iso3Code: "FRA",
    ),
    const Country(
      isoCode: "GF",
      phoneCode: "594",
      name: "French Guiana",
      iso3Code: "GUF",
    ),
    const Country(
      isoCode: "PF",
      phoneCode: "689",
      name: "French Polynesia",
      iso3Code: "PYF",
    ),
    const Country(
      isoCode: "TF",
      phoneCode: "262",
      name: "French Southern Territories",
      iso3Code: "ATF",
    ),
    const Country(
      isoCode: "GA",
      phoneCode: "241",
      name: "Gabon",
      iso3Code: "GAB",
    ),
    const Country(
      isoCode: "GM",
      phoneCode: "220",
      name: "Gambia",
      iso3Code: "GMB",
    ),
    const Country(
      isoCode: "GE",
      phoneCode: "995",
      name: "Georgia",
      iso3Code: "GEO",
    ),
    const Country(
      isoCode: "DE",
      phoneCode: "49",
      name: "Germany",
      iso3Code: "DEU",
    ),
    const Country(
      isoCode: "GH",
      phoneCode: "233",
      name: "Ghana",
      iso3Code: "GHA",
    ),
    const Country(
      isoCode: "GI",
      phoneCode: "350",
      name: "Gibraltar",
      iso3Code: "GIB",
    ),
    const Country(
      isoCode: "GR",
      phoneCode: "30",
      name: "Greece",
      iso3Code: "GRC",
    ),
    const Country(
      isoCode: "GL",
      phoneCode: "299",
      name: "Greenland",
      iso3Code: "GRL",
    ),
    const Country(
      isoCode: "GD",
      phoneCode: "1-473",
      name: "Grenada",
      iso3Code: "GRD",
    ),
    const Country(
      isoCode: "GP",
      phoneCode: "590",
      name: "Guadeloupe",
      iso3Code: "GLP",
    ),
    const Country(
      isoCode: "GU",
      phoneCode: "1-671",
      name: "Guam",
      iso3Code: "GUM",
    ),
    const Country(
      isoCode: "GT",
      phoneCode: "502",
      name: "Guatemala",
      iso3Code: "GTM",
    ),
    const Country(
      isoCode: "GG",
      phoneCode: "44-1481",
      name: "Guernsey",
      iso3Code: "GGY",
    ),
    const Country(
      isoCode: "GN",
      phoneCode: "224",
      name: "Guinea",
      iso3Code: "GIN",
    ),
    const Country(
      isoCode: "GW",
      phoneCode: "245",
      name: "Guinea-Bissau",
      iso3Code: "GNB",
    ),
    const Country(
      isoCode: "GY",
      phoneCode: "592",
      name: "Guyana",
      iso3Code: "GUY",
    ),
    const Country(
      isoCode: "HT",
      phoneCode: "509",
      name: "Haiti",
      iso3Code: "HTI",
    ),
    const Country(
      isoCode: "HM",
      phoneCode: "672",
      name: "Heard and McDonald Isles",
      iso3Code: "HMD",
    ),
    const Country(
      isoCode: "VA",
      phoneCode: "379",
      name: "Holy See (Vatican City State)",
      iso3Code: "VAT",
    ),
    const Country(
      isoCode: "HN",
      phoneCode: "504",
      name: "Honduras",
      iso3Code: "HND",
    ),
    const Country(
      isoCode: "HK",
      phoneCode: "852",
      name: "Hong Kong",
      iso3Code: "HKG",
    ),
    const Country(
      isoCode: "HU",
      phoneCode: "36",
      name: "Hungary",
      iso3Code: "HUN",
    ),
    const Country(
      isoCode: "IS",
      phoneCode: "354",
      name: "Iceland",
      iso3Code: "ISL",
    ),
    const Country(
      isoCode: "IN",
      phoneCode: "91",
      name: "India",
      iso3Code: "IND",
    ),
    const Country(
      isoCode: "ID",
      phoneCode: "62",
      name: "Indonesia",
      iso3Code: "IDN",
    ),
    const Country(
      isoCode: "IR",
      phoneCode: "98",
      name: "Iran",
      iso3Code: "IRN",
    ),
    const Country(
      isoCode: "IQ",
      phoneCode: "964",
      name: "Iraq",
      iso3Code: "IRQ",
    ),
    const Country(
      isoCode: "IE",
      phoneCode: "353",
      name: "Ireland",
      iso3Code: "IRL",
    ),
    const Country(
      isoCode: "IM",
      phoneCode: "44-1624",
      name: "Isle of Man",
      iso3Code: "IMN",
    ),
    const Country(
      isoCode: "IL",
      phoneCode: "972",
      name: "Israel",
      iso3Code: "ISR",
    ),
    const Country(
      isoCode: "IT",
      phoneCode: "39",
      name: "Italy",
      iso3Code: "ITA",
    ),
    const Country(
      isoCode: "JM",
      phoneCode: "1-876",
      name: "Jamaica",
      iso3Code: "JAM",
    ),
    const Country(
      isoCode: "JP",
      phoneCode: "81",
      name: "Japan",
      iso3Code: "JPN",
    ),
    const Country(
      isoCode: "JE",
      phoneCode: "44-1534",
      name: "Jersey",
      iso3Code: "JEY",
    ),
    const Country(
      isoCode: "JO",
      phoneCode: "962",
      name: "Jordan",
      iso3Code: "JOR",
    ),
    const Country(
      isoCode: "KZ",
      phoneCode: "7",
      name: "Kazakhstan",
      iso3Code: "KAZ",
    ),
    const Country(
      isoCode: "KE",
      phoneCode: "254",
      name: "Kenya",
      iso3Code: "KEN",
    ),
    const Country(
      isoCode: "KI",
      phoneCode: "686",
      name: "Kiribati",
      iso3Code: "KIR",
    ),
    const Country(
      isoCode: "KP",
      phoneCode: "850",
      name: "Korea, DPR",
      iso3Code: "PRK",
    ),
    const Country(
      isoCode: "KR",
      phoneCode: "82",
      name: "Korea, Republic of",
      iso3Code: "KOR",
    ),
    const Country(
      isoCode: "XK",
      phoneCode: "383",
      name: "Kosovo",
      iso3Code: "KOS",
    ),
    const Country(
      isoCode: "KW",
      phoneCode: "965",
      name: "Kuwait",
      iso3Code: "KWT",
    ),
    const Country(
      isoCode: "KG",
      phoneCode: "996",
      name: "Kyrgyzstan",
      iso3Code: "KGZ",
    ),
    const Country(
      isoCode: "LA",
      phoneCode: "",
      name: "Lao",
      iso3Code: "LAO",
    ),
    const Country(
      isoCode: "LV",
      phoneCode: "371",
      name: "Latvia",
      iso3Code: "LVA",
    ),
    const Country(
      isoCode: "LB",
      phoneCode: "961",
      name: "Lebanon",
      iso3Code: "LBN",
    ),
    const Country(
      isoCode: "LS",
      phoneCode: "266",
      name: "Lesotho",
      iso3Code: "LSO",
    ),
    const Country(
      isoCode: "LR",
      phoneCode: "231",
      name: "Liberia",
      iso3Code: "LBR",
    ),
    const Country(
      isoCode: "LY",
      phoneCode: "218",
      name: "Libya",
      iso3Code: "LBY",
    ),
    const Country(
      isoCode: "LI",
      phoneCode: "423",
      name: "Liechtenstein",
      iso3Code: "LIE",
    ),
    const Country(
      isoCode: "LT",
      phoneCode: "370",
      name: "Lithuania",
      iso3Code: "LTU",
    ),
    const Country(
      isoCode: "LU",
      phoneCode: "352",
      name: "Luxembourg",
      iso3Code: "LUX",
    ),
    const Country(
      isoCode: "MO",
      phoneCode: "853",
      name: "Macao",
      iso3Code: "MAC",
    ),
    const Country(
      isoCode: "MK",
      phoneCode: "389",
      name: "Macedonia",
      iso3Code: "MKD",
    ),
    const Country(
      isoCode: "MG",
      phoneCode: "261",
      name: "Madagascar",
      iso3Code: "MDG",
    ),
    const Country(
      isoCode: "MW",
      phoneCode: "265",
      name: "Malawi",
      iso3Code: "MWI",
    ),
    const Country(
      isoCode: "MY",
      phoneCode: "60",
      name: "Malaysia",
      iso3Code: "MYS",
    ),
    const Country(
      isoCode: "MV",
      phoneCode: "960",
      name: "Maldives",
      iso3Code: "MDV",
    ),
    const Country(
      isoCode: "ML",
      phoneCode: "223",
      name: "Mali",
      iso3Code: "MLI",
    ),
    const Country(
      isoCode: "MT",
      phoneCode: "356",
      name: "Malta",
      iso3Code: "MLT",
    ),
    const Country(
      isoCode: "MH",
      phoneCode: "692",
      name: "Marshall Islands",
      iso3Code: "MHL",
    ),
    const Country(
      isoCode: "MQ",
      phoneCode: "596",
      name: "Martinique",
      iso3Code: "MTQ",
    ),
    const Country(
      isoCode: "MR",
      phoneCode: "222",
      name: "Mauritania",
      iso3Code: "MRT",
    ),
    const Country(
      isoCode: "MU",
      phoneCode: "230",
      name: "Mauritius",
      iso3Code: "MUS",
    ),
    const Country(
      isoCode: "YT",
      phoneCode: "262",
      name: "Mayotte",
      iso3Code: "MYT",
    ),
    const Country(
      isoCode: "MX",
      phoneCode: "52",
      name: "Mexico",
      iso3Code: "MEX",
    ),
    const Country(
      isoCode: "FM",
      phoneCode: "691",
      name: "Micronesia",
      iso3Code: "FSM",
    ),
    const Country(
      isoCode: "MD",
      phoneCode: "373",
      name: "Moldova, Republic of",
      iso3Code: "MDA",
    ),
    const Country(
      isoCode: "MC",
      phoneCode: "377",
      name: "Monaco",
      iso3Code: "MCO",
    ),
    const Country(
      isoCode: "MN",
      phoneCode: "976",
      name: "Mongolia",
      iso3Code: "MNG",
    ),
    const Country(
      isoCode: "ME",
      phoneCode: "382",
      name: "Montenegro",
      iso3Code: "MNE",
    ),
    const Country(
      isoCode: "MS",
      phoneCode: "1-664",
      name: "Montserrat",
      iso3Code: "MSR",
    ),
    const Country(
      isoCode: "MA",
      phoneCode: "212",
      name: "Morocco",
      iso3Code: "MAR",
    ),
    const Country(
      isoCode: "MZ",
      phoneCode: "258",
      name: "Mozambique",
      iso3Code: "MOZ",
    ),
    const Country(
      isoCode: "MM",
      phoneCode: "95",
      name: "Myanmar",
      iso3Code: "MMR",
    ),
    const Country(
      isoCode: "NA",
      phoneCode: "264",
      name: "Namibia",
      iso3Code: "NAM",
    ),
    const Country(
      isoCode: "NR",
      phoneCode: "674",
      name: "Nauru",
      iso3Code: "NRU",
    ),
    const Country(
      isoCode: "NP",
      phoneCode: "977",
      name: "Nepal",
      iso3Code: "NPL",
    ),
    const Country(
      isoCode: "NL",
      phoneCode: "31",
      name: "Netherlands",
      iso3Code: "NLD",
    ),
    const Country(
      isoCode: "NC",
      phoneCode: "687",
      name: "New Caledonia",
      iso3Code: "NCL",
    ),
    const Country(
      isoCode: "NZ",
      phoneCode: "64",
      name: "New Zealand",
      iso3Code: "NZL",
    ),
    const Country(
      isoCode: "NI",
      phoneCode: "505",
      name: "Nicaragua",
      iso3Code: "NIC",
    ),
    const Country(
      isoCode: "NE",
      phoneCode: "227",
      name: "Niger",
      iso3Code: "NER",
    ),
    const Country(
      isoCode: "NG",
      phoneCode: "234",
      name: "Nigeria",
      iso3Code: "NGA",
    ),
    const Country(
      isoCode: "NU",
      phoneCode: "683",
      name: "Niue",
      iso3Code: "NIU",
    ),
    const Country(
      isoCode: "NF",
      phoneCode: "672",
      name: "Norfolk Island",
      iso3Code: "NFK",
    ),
    const Country(
      isoCode: "GB-NIR",
      phoneCode: "44",
      name: "Northern Ireland",
      iso3Code: "GBR",
    ),
    const Country(
      isoCode: "MP",
      phoneCode: "1-670",
      name: "Northern Mariana Islands",
      iso3Code: "MNP",
    ),
    const Country(
      isoCode: "NO",
      phoneCode: "47",
      name: "Norway",
      iso3Code: "NOR",
    ),
    const Country(
      isoCode: "OM",
      phoneCode: "968",
      name: "Oman",
      iso3Code: "OMN",
    ),
    const Country(
      isoCode: "PK",
      phoneCode: "92",
      name: "Pakistan",
      iso3Code: "PAK",
    ),
    const Country(
      isoCode: "PW",
      phoneCode: "680",
      name: "Palau",
      iso3Code: "PLW",
    ),
    const Country(
      isoCode: "PS",
      phoneCode: "970",
      name: "Palestine",
      iso3Code: "PSE",
    ),
    const Country(
      isoCode: "PA",
      phoneCode: "507",
      name: "Panama",
      iso3Code: "PAN",
    ),
    const Country(
      isoCode: "PG",
      phoneCode: "675",
      name: "Papua New Guinea",
      iso3Code: "PNG",
    ),
    const Country(
      isoCode: "PY",
      phoneCode: "595",
      name: "Paraguay",
      iso3Code: "PRY",
    ),
    const Country(
      isoCode: "PE",
      phoneCode: "51",
      name: "Peru",
      iso3Code: "PER",
    ),
    const Country(
      isoCode: "PH",
      phoneCode: "63",
      name: "Philippines",
      iso3Code: "PHL",
    ),
    const Country(
      isoCode: "PN",
      phoneCode: "64",
      name: "Pitcairn",
      iso3Code: "PCN",
    ),
    const Country(
      isoCode: "PL",
      phoneCode: "48",
      name: "Poland",
      iso3Code: "POL",
    ),
    const Country(
      isoCode: "PT",
      phoneCode: "351",
      name: "Portugal",
      iso3Code: "PRT",
    ),
    const Country(
      isoCode: "PR",
      phoneCode: "1-787",
      name: "Puerto Rico",
      iso3Code: "PRI",
    ),
    const Country(
      isoCode: "QA",
      phoneCode: "974",
      name: "Qatar",
      iso3Code: "QAT",
    ),
    const Country(
      isoCode: "RO",
      phoneCode: "40",
      name: "Romania",
      iso3Code: "ROU",
    ),
    const Country(
      isoCode: "RU",
      phoneCode: "7",
      name: "Russian Federation",
      iso3Code: "RUS",
    ),
    const Country(
      isoCode: "RW",
      phoneCode: "250",
      name: "Rwanda",
      iso3Code: "RWA",
    ),
    const Country(
      isoCode: "RE",
      phoneCode: "262",
      name: "Réunion",
      iso3Code: "REU",
    ),
    const Country(
      isoCode: "BL",
      phoneCode: "590",
      name: "Saint Barthélemy",
      iso3Code: "BLM",
    ),
    const Country(
      isoCode: "SH",
      phoneCode: "290",
      name: "Saint Helena",
      iso3Code: "SHN",
    ),
    const Country(
      isoCode: "KN",
      phoneCode: "1-869",
      name: "Saint Kitts and Nevis",
      iso3Code: "KNA",
    ),
    const Country(
      isoCode: "LC",
      phoneCode: "1-758",
      name: "Saint Lucia",
      iso3Code: "LCA",
    ),
    const Country(
      isoCode: "MF",
      phoneCode: "590",
      name: "Saint Martin",
      iso3Code: "MAF",
    ),
    const Country(
      isoCode: "PM",
      phoneCode: "508",
      name: "Saint Pierre and Miquelon",
      iso3Code: "SPM",
    ),
    const Country(
      isoCode: "VC",
      phoneCode: "1-784",
      name: "Saint Vincent and the Grenadines",
      iso3Code: "VCT",
    ),
    const Country(
      isoCode: "WS",
      phoneCode: "685",
      name: "Samoa",
      iso3Code: "WSM",
    ),
    const Country(
      isoCode: "SM",
      phoneCode: "378",
      name: "San Marino",
      iso3Code: "SMR",
    ),
    const Country(
      isoCode: "ST",
      phoneCode: "239",
      name: "Sao Tome and Principe",
      iso3Code: "STP",
    ),
    const Country(
      isoCode: "SA",
      phoneCode: "966",
      name: "Saudi Arabia",
      iso3Code: "SAU",
    ),
    const Country(
      isoCode: "GB-SCT",
      phoneCode: "44",
      name: "Scotland",
      iso3Code: "GBR",
    ),
    const Country(
      isoCode: "SN",
      phoneCode: "221",
      name: "Senegal",
      iso3Code: "SEN",
    ),
    const Country(
      isoCode: "RS",
      phoneCode: "381",
      name: "Serbia",
      iso3Code: "SRB",
    ),
    const Country(
      isoCode: "SC",
      phoneCode: "248",
      name: "Seychelles",
      iso3Code: "SYC",
    ),
    const Country(
      isoCode: "SL",
      phoneCode: "232",
      name: "Sierra Leone",
      iso3Code: "SLE",
    ),
    const Country(
      isoCode: "SG",
      phoneCode: "65",
      name: "Singapore",
      iso3Code: "SGP",
    ),
    const Country(
      isoCode: "SX",
      phoneCode: "1-721",
      name: "Sint Maarten (Dutch part)",
      iso3Code: "SXM",
    ),
    const Country(
      isoCode: "SK",
      phoneCode: "421",
      name: "Slovakia",
      iso3Code: "SVK",
    ),
    const Country(
      isoCode: "SI",
      phoneCode: "386",
      name: "Slovenia",
      iso3Code: "SVN",
    ),
    const Country(
      isoCode: "SB",
      phoneCode: "677",
      name: "Solomon Islands",
      iso3Code: "SLB",
    ),
    const Country(
      isoCode: "SO",
      phoneCode: "252",
      name: "Somalia",
      iso3Code: "SOM",
    ),
    const Country(
      isoCode: "ZA",
      phoneCode: "27",
      name: "South Africa",
      iso3Code: "ZAF",
    ),
    const Country(
      isoCode: "GS",
      phoneCode: "500",
      name: "South Georgia and South Sandwich",
      iso3Code: "SGS",
    ),
    const Country(
      isoCode: "SS",
      phoneCode: "211",
      name: "South Sudan",
      iso3Code: "SSD",
    ),
    const Country(
      isoCode: "ES",
      phoneCode: "34",
      name: "Spain",
      iso3Code: "ESP",
    ),
    const Country(
      isoCode: "LK",
      phoneCode: "94",
      name: "Sri Lanka",
      iso3Code: "LKA",
    ),
    const Country(
      isoCode: "SD",
      phoneCode: "249",
      name: "Sudan",
      iso3Code: "SDN",
    ),
    const Country(
      isoCode: "SR",
      phoneCode: "597",
      name: "Suriname",
      iso3Code: "SUR",
    ),
    const Country(
      isoCode: "SJ",
      phoneCode: "47",
      name: "Svalbard and Jan Mayen Islands",
      iso3Code: "SJM",
    ),
    const Country(
      isoCode: "SZ",
      phoneCode: "268",
      name: "Swaziland",
      iso3Code: "SWZ",
    ),
    const Country(
      isoCode: "SE",
      phoneCode: "46",
      name: "Sweden",
      iso3Code: "SWE",
    ),
    const Country(
      isoCode: "CH",
      phoneCode: "41",
      name: "Switzerland",
      iso3Code: "CHE",
    ),
    const Country(
      isoCode: "SY",
      phoneCode: "963",
      name: "Syrian Arab Republic",
      iso3Code: "SYR",
    ),
    const Country(
      isoCode: "TW",
      phoneCode: "886",
      name: "Taiwan",
      iso3Code: "TWN",
    ),
    const Country(
      isoCode: "TJ",
      phoneCode: "992",
      name: "Tajikistan",
      iso3Code: "TJK",
    ),
    const Country(
      isoCode: "TZ",
      phoneCode: "255",
      name: "Tanzania",
      iso3Code: "TZA",
    ),
    const Country(
      isoCode: "TH",
      phoneCode: "66",
      name: "Thailand",
      iso3Code: "THA",
    ),
    const Country(
      isoCode: "TL",
      phoneCode: "670",
      name: "Timor-Leste",
      iso3Code: "TLS",
    ),
    const Country(
      isoCode: "TG",
      phoneCode: "228",
      name: "Togo",
      iso3Code: "TGO",
    ),
    const Country(
      isoCode: "TK",
      phoneCode: "690",
      name: "Tokelau",
      iso3Code: "TKL",
    ),
    const Country(
      isoCode: "TO",
      phoneCode: "676",
      name: "Tonga",
      iso3Code: "TON",
    ),
    const Country(
      isoCode: "TT",
      phoneCode: "1-868",
      name: "Trinidad and Tobago",
      iso3Code: "TTO",
    ),
    const Country(
      isoCode: "TN",
      phoneCode: "216",
      name: "Tunisia",
      iso3Code: "TUN",
    ),
    const Country(
      isoCode: "TR",
      phoneCode: "90",
      name: "Turkey",
      iso3Code: "TUR",
    ),
    const Country(
      isoCode: "TM",
      phoneCode: "993",
      name: "Turkmenistan",
      iso3Code: "TKM",
    ),
    const Country(
      isoCode: "TC",
      phoneCode: "1-649",
      name: "Turks and Caicos Islands",
      iso3Code: "TCA",
    ),
    const Country(
      isoCode: "TV",
      phoneCode: "688",
      name: "Tuvalu",
      iso3Code: "TUV",
    ),
    const Country(
      isoCode: "UG",
      phoneCode: "256",
      name: "Uganda",
      iso3Code: "UGA",
    ),
    const Country(
      isoCode: "UA",
      phoneCode: "380",
      name: "Ukraine",
      iso3Code: "UKR",
    ),
    const Country(
      isoCode: "AE",
      phoneCode: "971",
      name: "United Arab Emirates",
      iso3Code: "ARE",
    ),
    const Country(
      isoCode: "GB",
      phoneCode: "44",
      name: "United Kingdom",
      iso3Code: "GBR",
    ),
    const Country(
      isoCode: "US",
      phoneCode: "1",
      name: "United States",
      iso3Code: "USA",
    ),
    const Country(
      isoCode: "UY",
      phoneCode: "598",
      name: "Uruguay",
      iso3Code: "URY",
    ),
    const Country(
      isoCode: "UM",
      phoneCode: "1",
      name: "US Minor Outlying Islands",
      iso3Code: "UMI",
    ),
    const Country(
      isoCode: "UZ",
      phoneCode: "998",
      name: "Uzbekistan",
      iso3Code: "UZB",
    ),
    const Country(
      isoCode: "VU",
      phoneCode: "678",
      name: "Vanuatu",
      iso3Code: "VUT",
    ),
    const Country(
      isoCode: "VE",
      phoneCode: "58",
      name: "Venezuela",
      iso3Code: "VEN",
    ),
    const Country(
      isoCode: "VN",
      phoneCode: "84",
      name: "Vietnam",
      iso3Code: "VNM",
    ),
    const Country(
      isoCode: "VG",
      phoneCode: "1-284",
      name: "Virgin Islands, British",
      iso3Code: "VGB",
    ),
    const Country(
      isoCode: "VI",
      phoneCode: "1-340",
      name: "Virgin Islands, U.S.",
      iso3Code: "VIR",
    ),
    const Country(
      isoCode: "GB-WLS",
      phoneCode: "44",
      name: "Wales",
      iso3Code: "GBR",
    ),
    const Country(
      isoCode: "WF",
      phoneCode: "681",
      name: "Wallis and Futuna Islands",
      iso3Code: "WLF",
    ),
    const Country(
      isoCode: "EH",
      phoneCode: "212",
      name: "Western Sahara",
      iso3Code: "ESH",
    ),
    const Country(
      isoCode: "YE",
      phoneCode: "967",
      name: "Yemen",
      iso3Code: "YEM",
    ),
    const Country(
      isoCode: "ZM",
      phoneCode: "260",
      name: "Zambia",
      iso3Code: "ZMB",
    ),
    const Country(
      isoCode: "ZW",
      phoneCode: "263",
      name: "Zimbabwe",
      iso3Code: "ZWE",
    ),
    const Country(
      isoCode: "AX",
      phoneCode: "358",
      name: "Åland Islands",
      iso3Code: "ALA",
    ),
  ];
}
