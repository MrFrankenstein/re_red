import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:intl/intl.dart';
import 'package:html_unescape/html_unescape_small.dart';

import 'package:re_red/constants.dart';
import 'package:re_red/styles_getter.dart';

class PostCard extends StatelessWidget {
  PostCard({this.post});

  final Submission post;

  @override
  Widget build(BuildContext context) {
    bool hasPreview = post.preview.isNotEmpty;
    if (hasPreview) hasPreview = post.preview.last.resolutions.isNotEmpty;

    Awardings allAwardings;
    bool hasAwards = false;
    if (post.data['total_awards_received'] > 0 &&
        post.data['all_awardings'] != null) {
      allAwardings = Awardings(
          awardingsData: post.data['all_awardings'],
          totalAwards: post.data['total_awards_received']);
      hasAwards = true;
    }

    print(post.variants);

    return IntrinsicHeight(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        overflow: Overflow.clip,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 300),
            child: hasPreview ? PreviewGetter(post).getPreview() : SizedBox(),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.black38,
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Container(
                        height: 33,
                        width: 33,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: subredditStyles[post.subreddit.displayName]
                              .primaryColor, //TODO: sometimes gets called on null
                        ),
                        child: ClipOval(
                          child: subredditStyles[post.subreddit.displayName]
                                      .subredditIconUrl ==
                                  ""
                              ? Icon(
                                  Icons.ac_unit_outlined,
                                  size: 22,
                                  color: subredditStyles[
                                                  post.subreddit.displayName]
                                              .primaryColor
                                              .computeLuminance() >
                                          0.5
                                      ? Color(0xff252527)
                                      : Color(0xfff8f8f8),
                                )
                              : Image.network(
                                  subredditStyles[post.subreddit.displayName]
                                      .subredditIconUrl),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 10,
                            top: 5,
                            bottom: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                            ),
                            color: Colors.black26,
                          ),
                          child: Text(
                            post.subreddit.displayName,
                            style: kPostSubreddit,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 8,
                            top: 3,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                            ),
                            color: Colors.black26,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: post.author, style: kPostAuthor),
                                kDotSeparator,
                                TextSpan(
                                  text: PostingTime()
                                      .getDuration(post.createdUtc),
                                  style: kPostAuthor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                hasPreview
                    ? Expanded(child: SizedBox(height: 10))
                    : SizedBox(height: 10),
                Row(children: TagsGetter(post).tags),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    HtmlUnescape().convert(post.title),
                    style: kPostTitle,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 12,
                        right: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.arrow_up_arrow_down,
                            color: kGreyShade,
                            size: 13,
                          ),
                          SizedBox(width: 3),
                          Text(
                            NumberFormat.compact().format(post.score),
                            style: kPostScore,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 1),
                    Container(
                      padding: EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        right: 8,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.bubble_left,
                            color: kGreyShade,
                            size: 13,
                          ),
                          SizedBox(width: 4),
                          Text(
                            NumberFormat.compact().format(post.numComments),
                            style: kPostScore,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 1),
                    hasAwards ? allAwardings.getAwardsPreview() : Container(),
                    Expanded(child: SizedBox(width: 10)),
                    Container(
                      height: 4,
                      width: post.upvoteRatio * 80,
                      decoration: BoxDecoration(
                        color: kRedShade,
                        border: Border(
                          top: kBorderStyle,
                          bottom: kBorderStyle,
                          left: kBorderStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 4,
                      width: 80 - (post.upvoteRatio * 80),
                      decoration: BoxDecoration(
                        color: kBlueShade,
                        border: Border(
                          top: kBorderStyle,
                          bottom: kBorderStyle,
                          right: kBorderStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TagsGetter {
  final Submission post;
  List<Widget> tags = [];

  TagsGetter(this.post) {
    getTags();
  }

  void getTags() {
    if (post.over18 || post.spoiler) {
      tags.add(SizedBox(width: 4));
    }

    if (post.over18) {
      tags.add(Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xCCFF6161),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Text(
          '18',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 11,
            fontFamily: 'Lora',
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    if (post.spoiler) {
      tags.add(Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Text(
          '!',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 11,
            fontFamily: 'NewYork',
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
  }
}

class PreviewGetter {
  PreviewGetter(this.post);
  final Submission post;

  Widget getPreview() {
    if (post.variants.isEmpty) {
      return Image.network(
        post.preview.last.resolutions.last.url.toString(),
        fit: BoxFit.fitWidth,
      );
    } else if (post.over18 || post.spoiler) {
      return Image.network(
        post.variants[0]['obfuscated'].resolutions.last.url.toString(),
        fit: BoxFit.fitWidth,
      );
    } else {
      return Image.network(
        post.variants[0]['gif'].resolutions.last.url.toString(),
        fit: BoxFit.fitWidth,
        gaplessPlayback: true,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return child; //TODO: use mp4 variants for streaming rather than gifs
        },
      );
    }
  }
}

class Awardings {
  final List awardingsData;
  final int totalAwards;

  Map awardingsMap = {};

  bool isSilver = false;
  bool isGold = false;
  bool isPlatinum = false;
  bool isArgentium = false;
  bool isTernion = false;

  List awardsPreviewList = [];

  Awardings({this.awardingsData, this.totalAwards}) {
    for (var award in awardingsData) {
      awardingsMap[award['name']] = {
        'name': award['name'],
        'count': award['count'],
        'description': award['description'],
        'iconUrl': HtmlUnescape().convert(award['icon_url']),
        'smallIconUrl':
            HtmlUnescape().convert(award['resized_icons'][1]['url']),
      };
    }

    if (awardingsMap.containsKey('Silver')) isSilver = true;
    if (awardingsMap.containsKey('Gold')) isGold = true;
    if (awardingsMap.containsKey('Platinum')) isPlatinum = true;
    if (awardingsMap.containsKey('Argentium')) isArgentium = true;
    if (awardingsMap.containsKey('Ternion All-Powerful')) isTernion = true;

    if (awardingsData.length > 0 && awardingsData.length < 4) {
      for (var award in awardingsMap.values) {
        awardsPreviewList.add(award);
      }
    } else {
      while (awardsPreviewList.length < 3) {
        if (isTernion) {
          awardsPreviewList.add(awardingsMap['Ternion All-Powerful']);
          isTernion = false;
        } else if (isArgentium) {
          awardsPreviewList.add(awardingsMap['Argentium']);
          isArgentium = false;
        } else if (isPlatinum) {
          awardsPreviewList.add(awardingsMap['Platinum']);
          isPlatinum = false;
        } else if (isGold) {
          awardsPreviewList.add(awardingsMap['Gold']);
          isGold = false;
        } else if (isSilver) {
          awardsPreviewList.add(awardingsMap['Silver']);
          isSilver = false;
        } else {
          for (var award in awardingsMap.values) {
            if (awardsPreviewList.length >= 3) break;
            if (!awardsPreviewList.contains(award))
              awardsPreviewList.add(award);
          }
          break;
        }
      }
    }
  }

  Container getAwardsPreview() {
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        right: 10,
        top: 2,
        bottom: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: awardsPreviewList
            .map((award) => Padding(
                  padding: const EdgeInsets.all(2),
                  child: getAwardIcon(award),
                ))
            .toList()
              ..add(totalAwards - awardsPreviewList.length == 0
                  ? Padding(padding: EdgeInsets.zero)
                  : Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        '+' +
                            NumberFormat.compact()
                                .format(totalAwards - awardsPreviewList.length)
                                .toString(),
                        style: kPostScore,
                      ),
                    )),
      ),
    );
  }

  Image getAwardIcon(Map award) {
    return Image.network(
      award['smallIconUrl'],
      width: 17,
    );
  }
}

class PostingTime {
  String getDuration(DateTime createdUtc) {
    final Duration timeElapsed = DateTime.now().toUtc().difference(createdUtc);
    if (timeElapsed.inSeconds < 60)
      return 'now'; //now
    else if (timeElapsed.inMinutes < 60)
      return '${timeElapsed.inMinutes}min'; //minutes
    else if (timeElapsed.inHours < 24)
      return '${timeElapsed.inHours}h'; //hours
    else if (timeElapsed.inDays < 7)
      return '${timeElapsed.inDays}d'; //days
    else if (timeElapsed.inDays < 30)
      return '${(timeElapsed.inDays / 7).floor()}w'; //weeks
    else if (timeElapsed.inDays < 365)
      return '${(timeElapsed.inDays / 30).floor()}mo'; //months
    else
      return '${(timeElapsed.inDays / 365).floor()}y';
  }
}
