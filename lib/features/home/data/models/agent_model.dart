class AgentResponse {
  final int status;
  final List<Agent> agents;

  AgentResponse({
    required this.status,
    required this.agents,
  });

  factory AgentResponse.fromMap(Map<String, dynamic> json) {
    return AgentResponse(
      status: json['status'] as int,
      agents: (json['agents'] as List)
          .map((agent) => Agent.fromJson(agent))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'agents': agents.map((agent) => agent.toJson()).toList(),
    };
  }
}

class Agent {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String country;
  final String city;
  final String createdAt;
  final String updatedAt;
  final String? website; // Add website field

  Agent({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.country,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    this.website, // Optional website field
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      website: json['website'] as String?, // Parse website field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'country': country,
      'city': city,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'website': website,
    };
  }
}