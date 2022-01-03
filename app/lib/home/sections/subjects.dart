import 'package:flutter/material.dart';

import 'section.dart';


class SubjectsSection extends Section {
	@override
	final String name = "subjects";
	@override
	final IconData icon = Icons.school;
	@override
	final bool hasAddAction = true;

	const SubjectsSection();

	@override
	Widget build(BuildContext context) {
		return Center(child: Icon(icon));
	}

	@override
	void addAction() {
		print("subjects add action");
	}
}
