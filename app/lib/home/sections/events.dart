import 'package:flutter/material.dart';

import 'section.dart';


class EventsSection extends Section {
	@override
	final String name = "events";
	@override
	final IconData icon = Icons.event_note;

	const EventsSection();

	@override
	Widget build(BuildContext context) {
		return Center(child: Icon(icon));
	}
}
