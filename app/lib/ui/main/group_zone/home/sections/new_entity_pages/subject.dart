import 'package:flutter/material.dart';

import 'package:podiynyk/storage/cloud.dart' show Cloud;

import 'package:podiynyk/ui/main/widgets/fields.dart' show InputField;

import 'entity.dart';


class NewSubjectPage extends StatelessWidget {
	final _nameField = TextEditingController();

	@override
	Widget build(BuildContext context) => NewEntityPage(
		addEntity: _add,
		children: [InputField(
			controller: _nameField,
			name: "name",
		)]
	);

	void _add(BuildContext context) {
		final name = _nameField.text;
		if (name.isEmpty) return;

		Navigator.of(context).pop();
		Cloud.addSubject(name: name);
	}
}
