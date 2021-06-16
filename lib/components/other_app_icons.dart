import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

const kDefaultSocialIconSize = 30.0;

class SpotifyIcon extends StatelessWidget {
  final double? size;
  const SpotifyIcon({this.size = kDefaultSocialIconSize});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/other_app_icons/spotify_icon.svg',
        width: size);
  }
}

class YouTubeIcon extends StatelessWidget {
  final double? size;
  const YouTubeIcon({this.size = kDefaultSocialIconSize});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/other_app_icons/youtube.svg', width: size);
  }
}

class InstagramIcon extends StatelessWidget {
  final double? size;
  const InstagramIcon({this.size = kDefaultSocialIconSize});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/other_app_icons/instagram_icon.svg',
        width: size);
  }
}

class TikTokIcon extends StatelessWidget {
  final double? size;
  TikTokIcon({this.size = kDefaultSocialIconSize});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/other_app_icons/tiktok_icon.svg',
        width: size);
  }
}

class SnapIcon extends StatelessWidget {
  final double? size;
  SnapIcon({this.size = kDefaultSocialIconSize});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/other_app_icons/snap_icon.svg',
        width: size);
  }
}

class LinkedInIcon extends StatelessWidget {
  final double? size;
  LinkedInIcon({this.size = kDefaultSocialIconSize});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/other_app_icons/linkedin_icon.svg',
        width: size);
  }
}
