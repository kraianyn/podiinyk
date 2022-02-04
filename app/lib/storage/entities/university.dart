import '../cloud.dart' show Cloud;

import 'identification_option.dart';
import 'department.dart';


class University implements IdentificationOption {
	@override
	final String id;
	@override
	final String name;
	
	const University({
		required this.id,
		required this.name
	});

	Future<List<Department>> get departments => Cloud.departments(this);
}