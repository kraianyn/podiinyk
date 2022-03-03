import 'package:flutter/material.dart';

import 'package:podiynyk/storage/cloud.dart';

import 'package:podiynyk/ui/main/common/fields.dart';

import 'entity.dart';


// todo: what if there are no subjects?
// todo: exclude the unfollowed subjects from the options?
// todo: access the subjectNames through the context?
class NewEventPage extends StatefulWidget {
	final bool askSubject;
	final bool subjectRequired;
	final String? subjectName;

	const NewEventPage() :
		askSubject = true,
		subjectRequired = false,
		subjectName = null;

	const NewEventPage.subjectEvent(this.subjectName) :
		askSubject = false,
		subjectRequired = true;

	const NewEventPage.nonSubjectEvent() :
		askSubject = false,
		subjectRequired = false,
		subjectName = null;

	@override
	State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
	late final Future<List<String>> _subjectNames;

	final _nameField = TextEditingController();
	final _subjectField = TextEditingController();
	final _noteField = TextEditingController();

	String? _subjectName;
	DateTime? _date;

	@override
	void initState() {
		super.initState();
		_subjectName = widget.subjectName;
		if (widget.askSubject) _subjectNames = Cloud.subjectNames;
	}

	@override
	Widget build(BuildContext context) => NewEntityPage(
		add: _add,
		children: [
			InputField(
				controller: _nameField,
				name: "name"
			),
			// todo: removing the chosen subject
			if (widget.askSubject) OptionField(
				controller: _subjectField,
				name: "subject",
				showOptions: _askSubject
			),
			DateField(onDatePicked: (date) => _date = date),
			InputField(
				controller: _noteField,
				name: "note"
			)
		]
	);


	void _askSubject(BuildContext context) {
		Navigator.of(context).push(MaterialPageRoute(
			builder: (context) => Scaffold(
				body: Center(child: FutureBuilder(
					future: _subjectNames,
					builder: _subjectsBuilder
				))
			)
		));
	}

	Widget _subjectsBuilder(BuildContext context, AsyncSnapshot<List<String>> snapshot) {
		if (snapshot.connectionState == ConnectionState.waiting) return const Icon(Icons.cloud_download);
		// if (snapshot.hasError) print(snapshot.error);  // todo: consider handling

		return ListView(
			shrinkWrap: true,
			children: [
				for (final name in snapshot.data!) ListTile(
					title: Text(name),
					onTap: () {
						_subjectName = name;
						_subjectField.text = name;
						Navigator.of(context).pop();
					}
				)
			]
		);
	}

	bool _add(BuildContext context) {
		final name = _nameField.text;
		if (
			name.isEmpty ||
			(widget.subjectRequired && _subjectName == null) ||
			_date == null
		) return false;

		// idea: show an animation of the event flying away?
		// idea: show the result of the request on the page?

		final note = _noteField.text;
		Cloud.addEvent(
			name: name,
			subjectName: _subjectName,
			date: _date!,
			note: note.isNotEmpty ? note : null
		);
		return true;
	}
}
