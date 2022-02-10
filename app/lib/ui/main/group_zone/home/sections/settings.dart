import 'package:flutter/material.dart';

import 'section.dart';


class SettingsSection extends Section {
	static const name = "settings";
	static const icon = Icons.settings;

	const SettingsSection();

	@override
	String get sectionName => name;
	@override
	IconData get sectionIcon => icon;

	// todo: define
	@override
	Widget build(BuildContext context) {
		return const Center(child: Icon(icon));
	}
}