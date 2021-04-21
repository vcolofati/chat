import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final Key? key;
  final String message;
  final DateTime hour;
  final bool belongsToMe;

  MessageBubble(this.message, this.hour, this.belongsToMe, {this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
                belongsToMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: belongsToMe
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: belongsToMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          width: 250,
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    color: belongsToMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1?.color,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Text(
                DateFormat('HH:mm').format(hour),
                style: TextStyle(
                  color: belongsToMe ? Colors.grey : Colors.amber,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
