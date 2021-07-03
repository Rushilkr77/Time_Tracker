class Job {
  final String name;
  final int rateperhour;

  Job({this.name, this.rateperhour});

  factory Job.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int rateperhour = data['rateperhour'];
    return Job(
      name: name,
      rateperhour: rateperhour,
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'rateperhour': rateperhour,
    };
  }
}
