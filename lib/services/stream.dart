import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// Chat and Feeds service from getStream.io
abstract class StreamService {
  static theme(BuildContext context) {
    final bool isDark = context.theme.brightness == Brightness.dark;
    final primary = context.theme.primary;
    final background = context.theme.background;
    final cardBackground = context.theme.cardBackground;

    return StreamChatThemeData(
      brightness: context.theme.brightness,
      primaryIconTheme: IconThemeData(color: primary),
      colorTheme: isDark
          ? ColorTheme.dark(
              accentPrimary: primary,
            )
          : ColorTheme.light(accentPrimary: primary),
      messageInputTheme: MessageInputTheme(
          inputTextStyle: GoogleFonts.sourceSansPro(),
          inputBackground: cardBackground),
      channelListViewTheme:
          ChannelListViewThemeData(backgroundColor: background),
      messageListViewTheme:
          MessageListViewThemeData(backgroundColor: background),
      channelTheme: ChannelTheme(
        channelHeaderTheme: ChannelHeaderTheme(
          color: background,
          title: GoogleFonts.archivo(textStyle: TextStyle(color: primary)),
          subtitle: GoogleFonts.sourceSansPro(),
        ),
      ),
    );
  }
}
