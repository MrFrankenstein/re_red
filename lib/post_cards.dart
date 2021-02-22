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
    return IntrinsicHeight(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        overflow: Overflow.clip,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 250),
            child: hasPreview
                ? Image.network(
                    post.preview.last.resolutions.last.url.toString(),
                    fit: BoxFit.fitWidth,
                  )
                : SizedBox(),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.black54,
                  Colors.black26,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: subredditStyles[post.subreddit.displayName]
                            .primaryColor,
                      ),
                      child: ClipOval(
                        child: subredditStyles[post.subreddit.displayName]
                                    .subredditIconUrl ==
                                ""
                            ? Icon(
                                Icons.ac_unit_outlined,
                                size: 22,
                                color:
                                    subredditStyles[post.subreddit.displayName]
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
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //TODO: Get inverted rounded edges
                          child: Text(
                            post.subreddit.displayName,
                            style: kPostSubreddit,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: post.author, style: kPostAuthor),
                              kDotSeparator,
                              TextSpan(
                                text:
                                    PostingTime().getDuration(post.createdUtc),
                                style: kPostAuthor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                hasPreview
                    ? Expanded(child: SizedBox(height: 10))
                    : SizedBox(height: 10),
                Text(
                  HtmlUnescape().convert(post.title),
                  style: kPostTitle,
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
                        right: 12,
                        left: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
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
                    Spacer(),
                    // Image.asset(
                    //   'assets/awards/platinum.png',  //TODO
                    //   scale: 1.5,
                    // ),
                    // Spacer(),
                    Container(
                      height: 4,
                      width: post.upvoteRatio * 100,
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
                      width: 100 - (post.upvoteRatio * 100),
                      decoration: BoxDecoration(
                        color: kBlueShade,
                        border: Border(
                          top: kBorderStyle,
                          bottom: kBorderStyle,
                          right: kBorderStyle,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
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
