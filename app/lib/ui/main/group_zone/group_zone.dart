import 'package:flutter/material.dart';

import 'leader_election.dart';
import 'home/home.dart';


class GroupZone extends StatefulWidget {
	final bool leaderIsElected;

	const GroupZone({required this.leaderIsElected});

	@override
	State<GroupZone> createState() => _GroupZoneState();
}

class _GroupZoneState extends State<GroupZone> {
	late bool _leaderIsElected;

	@override
	void initState() {
		_leaderIsElected = widget.leaderIsElected;
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return _leaderIsElected ? const Home() : LeaderElection(
			end: () => setState(() { _leaderIsElected = true; })
		);
	}
}