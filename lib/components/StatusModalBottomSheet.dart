import 'package:flutter/material.dart';
import 'package:teste/common/enum/Status.dart';

class StatusModalBottomSheet extends StatelessWidget {
  String? _status;
  Function(String value)? _onPressed;

  StatusModalBottomSheet(
      {required String status, required Function(String value) onPressed}) {
    this._status = status;
    this._onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Status.filteredValues(this._status!)!.length,
              itemBuilder: (BuildContext ctx, int index) => TextButton(
                  onPressed: () => {
                        this._onPressed!(Status.filteredValues(this._status!)!
                            .values
                            .elementAt(index)),
                        Navigator.pop(context),
                      },
                  child: Text(Status.filteredValues(this._status!)!
                      .keys
                      .elementAt(index))),
            ),
          )
        ],
      ),
    );
  }
}
