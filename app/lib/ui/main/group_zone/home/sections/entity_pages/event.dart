import 'package:flutter/material.dart';

import 'package:podiynyk/storage/cloud.dart' show Cloud;
import 'package:podiynyk/storage/local.dart';
import 'package:podiynyk/storage/entities/event.dart' show Event;

import 'package:podiynyk/ui/main/widgets/fields.dart' show InputField;

import '../section.dart' show EntityDate;
import 'entity.dart';


class EventPage extends StatefulWidget {
	final Event _event;
	final _nameField = TextEditingController();
	final _noteField = TextEditingController();

	EventPage(this._event);

	@override
	State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
	@override
	void initState() {
		widget._event.addDetails().whenComplete(() => setState(() {}));
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		final event = widget._event;
		final subject = event.subject;
		final note = event.note;
		final hasNote = note != null;

		widget._nameField.text = event.name;
		if (hasNote) widget._noteField.text = note;

		return EntityPage(
			children: [
				TextField(
					controller: widget._nameField,
					decoration: const InputDecoration(hintText: "name"),
					onSubmitted: (label) {},  // todo: add the label
				),
				if (subject != null) Text(subject),
				Text(event.date.fullRepr),  // todo: allow changing
				if (hasNote) TextField(
					controller: widget._noteField,
					decoration: const InputDecoration(hintText: "to be deleted"),
					onSubmitted: (newNote) {},  // todo: update the note
				)
			],
			actions: [
				if (event.note == null) EntityActionButton(
					text: "add a note",
					action: () => Navigator.of(context).push(MaterialPageRoute(
						builder: (_) => GestureDetector(
							onDoubleTap: addNote,
							child: Scaffold(
								body: Center(child: InputField(
									controller: widget._noteField,
									name: "note"
								))
							)
						)
					))
				),
				// todo: implement the queues feature, add (schedule / start, delete) buttons
				EntityActionButton(
					text: "hide",
					action: () => Local.addStoredEntity(DataBox.hiddenEvents, event)
				),
				EntityActionButton(
					text: "delete",
					action: () => Cloud.deleteEvent(event)
				)
			]
		);
	}

	void addNote() {
		widget._event.note = widget._noteField.text;
		Cloud.updateEventNote(widget._event);
		Navigator.of(context).pop();
	}
}
