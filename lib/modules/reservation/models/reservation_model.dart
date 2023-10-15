class Reservation {
  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Stay>? stays;
  final List<UserTicket>? userTickets;

  Reservation({
    this.id,
    this.startDate,
    this.endDate,
    this.stays,
    this.userTickets,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        stays: json["stays"] == null
            ? []
            : List<Stay>.from(json["stays"]!.map((x) => Stay.fromJson(x))),
        userTickets: json["user_tickets"] == null
            ? []
            : List<UserTicket>.from(
                json["user_tickets"]!.map((x) => UserTicket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "stays": stays == null
            ? []
            : List<dynamic>.from(stays!.map((x) => x.toJson())),
        "user_tickets": userTickets == null
            ? []
            : List<dynamic>.from(userTickets!.map((x) => x.toJson())),
      };
}

class Stay {
  final String? name;
  final String? description;
  final double? lat;
  final double? lng;
  final String? address;
  final String? checkIn;
  final String? checkOut;
  final int? stars;
  final List<String>? stayImages;
  final String? amenities;
  final List<Room>? rooms;

  Stay({
    this.name,
    this.description,
    this.lat,
    this.lng,
    this.address,
    this.checkIn,
    this.checkOut,
    this.stars,
    this.stayImages,
    this.amenities,
    this.rooms,
  });

  factory Stay.fromJson(Map<String, dynamic> json) => Stay(
        name: json["name"],
        description: json["description"],
        lat: double.tryParse(json["lat"].toString()),
        lng: double.tryParse(json["lng"].toString()) ,
        address: json["address"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        stars: json["stars"],
        stayImages: json["stay_images"] == null
            ? []
            : List<String>.from(json["stay_images"]!.map((x) => x)),
        amenities: json["amenities"],
        rooms: json["rooms"] == null
            ? []
            : List<Room>.from(json["rooms"]!.map((x) => Room.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "lat": lat,
        "lng": lng,
        "address": address,
        "check_in": checkIn,
        "check_out": checkOut,
        "stars": stars,
        "stay_images": stayImages == null
            ? []
            : List<dynamic>.from(stayImages!.map((x) => x)),
        "amenities": amenities,
        "rooms": rooms == null
            ? []
            : List<dynamic>.from(rooms!.map((x) => x.toJson())),
      };
}

class Room {
  final String ? roomNumber;
  final int? roomCapacity;
  final String? roomTypeName;
  final String? stayName;
  final List<TicketUserData>? guests;

  Room({
    this.roomNumber,
    this.roomCapacity,
    this.roomTypeName,
    this.stayName,
    this.guests,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        roomNumber: json["room_number"].toString(),
        roomCapacity: json["room_capacity"],
        roomTypeName: json["room_type_name"],
        stayName: json["stay_name"],
        guests: json["guests"] == null
            ? []
            : List<TicketUserData>.from(
                json["guests"]!.map((x) => TicketUserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "room_number": roomNumber,
        "room_capacity": roomCapacity,
        "room_type_name": roomTypeName,
        "stay_name": stayName,
        "guests": guests == null
            ? []
            : List<dynamic>.from(guests!.map((x) => x.toJson())),
      };
}

class TicketUserData {
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final bool? isUser;

  TicketUserData({
    this.firstName,
    this.lastName,
    this.avatar,
    this.isUser,
  });

  factory TicketUserData.fromJson(Map<String, dynamic> json) => TicketUserData(
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
        isUser: json["is_user"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "is_user": isUser,
      };
}

class UserTicket {
  final int? ticketId;
  final String ? seat;
  final String? ticketSystemId;
  final String? ticketTypeName;
  final TicketUserData? ticketUserData;
  final String ? gate;

  UserTicket({
    this.ticketId,
    this.seat,
    this.ticketSystemId,
    this.ticketTypeName,
    this.ticketUserData,
    this.gate,
  });

  factory UserTicket.fromJson(Map<String, dynamic> json) => UserTicket(
        ticketId: json["ticket_id"],
        seat: json["seat"].toString(),
        ticketSystemId: json["ticket_system_id"],
        ticketTypeName: json["ticket_type_name"],
        ticketUserData: json["ticket_user_data"] == null
            ? null
            : TicketUserData.fromJson(json["ticket_user_data"]),
        gate: json["gate"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
        "seat": seat,
        "ticket_system_id": ticketSystemId,
        "ticket_type_name": ticketTypeName,
        "ticket_user_data": ticketUserData?.toJson(),
        "gate": gate,
      };
}
