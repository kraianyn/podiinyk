import 'package:flutter/material.dart';

import 'package:podiynyk/storage/cloud.dart';
import 'package:podiynyk/storage/entities/date.dart';
import 'package:podiynyk/storage/entities/student.dart' show Role;
import 'package:podiynyk/storage/entities/subject.dart';

import 'section.dart';
import 'entity_pages/subject.dart';
import 'new_entity_pages/subject.dart';


class SubjectsSectionCloudData extends CloudEntitiesSectionData<Subject> {
	final subjects = Cloud.subjects;

	@override
	Future<List<Subject>> get counted => subjects;
}


class SubjectsSection extends CloudEntitiesSection<SubjectsSectionCloudData, Subject> {
	static const name = "subjects";
	static const icon = Icons.school;

	SubjectsSection() : super(SubjectsSectionCloudData());

	@override
	String get sectionName => name;
	@override
	IconData get sectionIcon => icon;
	@override
	Widget? get actionButton => Cloud.role != Role.leader ? super.actionButton : NewEntityButton(
		pageBuilder: (_) => NewSubjectPage()
	);

	@override
	Future<List<Subject>> get entities => data.subjects;

	@override
	List<Widget> tiles(BuildContext context, List<Subject> subjects) => [
		for (final subject in subjects.where((subject) => subject.isFollowed)) tile(context, subject),
		for (final subject in subjects.where((subject) => !subject.isFollowed)) Opacity(
			opacity: 0.5,
			child: tile(context, subject)
		),
		const ListTile()
	];

	Widget tile(BuildContext context, Subject subject) {
		final hasEvents = subject.events.isNotEmpty;

		return EntityTile(
			title: subject.nameRepr,
			subtitle: hasEvents ? subject.eventCountRepr : null,
			trailing: hasEvents ? subject.events.first.date.dateRepr : null,
			pageBuilder: () => SubjectPage(subject)
		);
	}
}
