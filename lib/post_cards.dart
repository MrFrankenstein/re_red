import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:intl/intl.dart';

import 'package:re_red/constants.dart';
import 'package:re_red/styles_getter.dart';

class PostCard extends StatelessWidget {
  PostCard({this.post});

  final Submission post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  height: 30,
                  width: 30,
                  color:
                      subredditStyles[post.subreddit.displayName].primaryColor,
                  child: subredditStyles[post.subreddit.displayName]
                              .subredditIconUrl ==
                          ""
                      ? Icon(
                          Icons.ac_unit_outlined,
                          size: 22,
                          color: subredditStyles[post.subreddit.displayName]
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
                  Text(
                    post.subreddit.displayName,
                    style: kPostSubreddit,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: post.author, style: kPostAuthor),
                        kDotSeparator,
                        TextSpan(
                          text: PostingTime().getDuration(post.createdUtc),
                          style: kPostAuthor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            post.title,
            style: kPostTitle,
            // textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                CupertinoIcons.arrow_up_arrow_down,
                color: Colors.white70,
                size: 13,
              ),
              SizedBox(width: 3),
              Text(
                NumberFormat.compact().format(post.score),
                style: kPostScore,
              ),
              SizedBox(width: 15),
              Icon(
                CupertinoIcons.bubble_left,
                color: Colors.white70,
                size: 13,
              ),
              SizedBox(width: 4),
              Text(
                NumberFormat.compact().format(post.numComments),
                style: kPostScore,
              ),
              Spacer(),
              Container(
                height: 3,
                width: post.upvoteRatio * 100,
                color: Colors.red,
              ),
              Container(
                height: 3,
                width: 100 - (post.upvoteRatio * 100),
                color: Colors.blue,
              ),
              SizedBox(width: 20),
            ],
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
