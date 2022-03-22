import 'package:flutter/material.dart';

import 'package:podiynyk/storage/cloud.dart';
import 'package:podiynyk/storage/entities/date.dart';
import 'package:podiynyk/storage/entities/message.dart';
import 'package:podiynyk/storage/entities/student.dart' show Role;

import 'section.dart';
import 'entity_pages/message.dart';
import 'new_entity_pages/message.dart';


class MessagesSectionData extends CloudEntitiesSectionData<Message> {
	@override
	Future<List<Message>> get entitiesFuture => Cloud.messages;
}


class MessagesSection extends CloudEntitiesSection<MessagesSectionData, Message> {
	static const name = "messages";
	static const icon = Icons.messenger;

	@override
	String get sectionName => name;
	@override
	IconData get sectionIcon => icon;

	@override
	Widget? get actionButton => Cloud.userRole == Role.ordinary ? null : NewEntityButton(
		pageBuilder: (_) => NewMessagePage()
	);

	@override
	MessagesSectionData get data => MessagesSectionData();

	@override
	List<Widget> tiles(BuildContext context, List<Message> messages) => [
		for (final message in messages) EntityTile(
			title: message.name,
			subtitle: message.author.nameRepr,
			trailing: message.date.dateRepr,
			pageBuilder: () => MessagePage(message)
		),
		if (Cloud.userRole != Role.ordinary) const ListTile()
	];
}
