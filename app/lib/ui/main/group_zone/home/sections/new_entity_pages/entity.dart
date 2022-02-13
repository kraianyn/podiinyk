import 'package:flutter/material.dart';


class NewEntityPage extends StatelessWidget {
	final List<Widget> children;
	final bool Function(BuildContext context) add;

	const NewEntityPage({
		required this.children,
		required this.add
	});

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			// todo: display the new entity in the list (consider updating the list instead of rebuilding)
			onDoubleTap: () {
				final added = add(context);
				if (added) Navigator.of(context).pop();
			},
			child: Scaffold(
				body: Center(child: ListView(
					shrinkWrap: true,
					children: children
				))
			)
		);
	}
}
