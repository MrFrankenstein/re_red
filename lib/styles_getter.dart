import 'dart:collection';
import 'dart:convert';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;

const String stylesUrl = 'https://www.reddit.com/api/info.json?sr_name=';
HashMap<String, StyleObject> subredditStyles = HashMap<String, StyleObject>();

class StylesGetter {
  Future<void> getStyles(List<Submission> contentList) async {
    HashSet<String> newItems = HashSet<String>();
    for (Submission submission in contentList) {
      if (!subredditStyles.keys.contains(submission.subreddit.displayName)) {
        newItems.add(submission.subreddit.displayName);
      }
    }
    var response = await http.get(Uri.parse(stylesUrl + newItems.join(',')));
    var styles = jsonDecode(response.body);
    for (var style in styles['data']['children']) {
      if (style['kind'] == 't5') {
        subredditStyles[style['data']['display_name']] = StyleObject(
          subredditIconUrl: getIconUrl(style['data']),
          subredditBannerUrl: getBannerUrl(style['data']),
          primaryColor: getPrimaryColor(style['data']),
          keyColor: getKeyColor(style['data']),
          subredditDescription: getSubredditDescription(style['data']),
          subredditTitle: getSubredditTitle(style['data']),
        );
      }
    }
  }

  String getIconUrl(var styleData) {
    if (styleData.containsKey('community_icon') &&
        !["", null].contains(styleData['community_icon']))
      return HtmlUnescape().convert(styleData['community_icon']);
    else if (styleData.containsKey('icon_img') &&
        !["", null].contains(styleData['icon_img']))
      return HtmlUnescape().convert(styleData['icon_img']);
    else
      return "";
  }

  String getBannerUrl(var styleData) {
    if (styleData.containsKey('banner_img') &&
        !["", null].contains(styleData['banner_img']))
      return HtmlUnescape().convert(styleData['banner_img']);
    else if (styleData.containsKey('banner_background_image') &&
        !["", null].contains(styleData['banner_background_image']))
      return HtmlUnescape().convert(styleData['banner_background_image']);
    else if (styleData.containsKey('header_img') &&
        !["", null].contains(styleData['header_img']))
      return HtmlUnescape().convert(styleData['header_img']);
    else
      return "";
  }

  Color getPrimaryColor(var styleData) {
    if (styleData.containsKey('primary_color') &&
        !["", null].contains(styleData['primary_color']))
      return Color(
          int.parse(styleData['primary_color'].replaceAll('#', '0xFF')));
    else
      return Colors.white;
  }

  Color getKeyColor(var styleData) {
    if (styleData.containsKey('key_color') &&
        !["", null].contains(styleData['key_color']))
      return Color(int.parse(styleData['key_color'].replaceAll('#', '0xFF')));
    else
      return Colors.white70;
  }

  String getSubredditDescription(var styleData) {
    return HtmlUnescape().convert(styleData['public_description']);
  }

  String getSubredditTitle(var styleData) {
    return HtmlUnescape().convert(styleData['title']);
  }
}

class StyleObject {
  StyleObject({
    this.subredditIconUrl,
    this.subredditBannerUrl,
    this.primaryColor,
    this.keyColor,
    this.subredditTitle,
    this.subredditDescription,
  });

  final String? subredditIconUrl;
  final String? subredditBannerUrl;
  final Color? primaryColor;
  final Color? keyColor;
  final String? subredditTitle;
  final String? subredditDescription;
}
