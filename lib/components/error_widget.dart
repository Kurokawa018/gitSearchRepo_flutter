
import 'package:flutter/material.dart';

//constants
import '../constants/doubles.dart';
import '../constants/strings.dart';

class SearchError extends StatelessWidget {
  SearchError({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: sizedHeight,),
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(errorTitle,
                style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(errorText,
                style: Theme.of(context).textTheme.subtitle1),
          ),
        ],
      ),
    );
  }
}

