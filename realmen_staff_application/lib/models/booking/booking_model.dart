class BookingModel {
  // To json
  String? appointmentDate;
  int? branchId;
  int? accountId;
  List<BookingServiceModel>? bookingServices;

  // From Json
  List<BookingContent>? content;
  int? totalElements;
  int? totalPages;
  int? pageSize;
  int? current;

  BookingModel({
    // To json
    this.appointmentDate,
    this.branchId,
    this.accountId,
    this.bookingServices,

    // From Json
    this.content,
    this.totalElements,
    this.totalPages,
    this.pageSize,
    this.current,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointmentDate': appointmentDate,
      'branchId': branchId,
      'accountId': accountId,
      'bookingServices': bookingServices != null
          ? bookingServices!.map((service) => service.toJson()).toList()
          : [],
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      content: json['content'] != null
          ? (json['content'] as List)
              .map((e) => BookingContent.fromJson(e))
              .toList()
          : null,
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      pageSize: json['pageSize'],
      current: json['current'],
    );
  }
}

class BookingContent {
  int? bookingId;
  int? customerId;
  int? branchId;
  String? bookingCode;
  String? bookingOwnerName;
  String? bookingOwnerPhone;
  String? branchAddress;
  String? branchName;
  String? appointmentDate;
  int? totalBookingPrice;
  List<BookingServiceModel>? bookingServices;
  String? bookingStatus;
  bool? allowProcess;

  BookingContent({
    this.bookingId,
    this.customerId,
    this.branchId,
    this.bookingCode,
    this.bookingOwnerName,
    this.bookingOwnerPhone,
    this.branchAddress,
    this.branchName,
    this.appointmentDate,
    this.bookingServices,
    this.bookingStatus,
    this.totalBookingPrice,
    this.allowProcess,
  });

  factory BookingContent.fromJson(Map<String, dynamic> json) {
    return BookingContent(
      bookingId: json['bookingId'],
      customerId: json['customerId'],
      branchId: json['branchId'],
      bookingCode: json['bookingCode'],
      bookingOwnerName: json['bookingOwnerName'],
      bookingOwnerPhone: json['bookingOwnerPhone'],
      branchAddress: json['branchAddress'],
      branchName: json['branchName'],
      appointmentDate: json['appointmentDate'],
      bookingServices: json['bookingServices'] != null
          ? ((json['bookingServices'] as List)
              .map((e) => BookingServiceModel.fromJson(e))
              .toList())
          : null,
      bookingStatus: json['bookingStatus'],
      totalBookingPrice: json['totalBookingPrice'],
      allowProcess: json['allowProcess'],
    );
  }
}

class BookingServiceModel {
  int? bookingServiceId;
  int? bookingId;
  int? serviceId;
  int? staffId;
  String? serviceName;
  int? servicePrice;
  String? staffName;
  String? staffPhone;
  String? startAppointment;
  String? actualStartAppointment;
  String? endAppointment;
  String? actualEndAppointment;
  String? duration;
  String? durationText;
  String? bookingServiceStatus;
  String? professional;

  String? bookingServiceType;
  String? bookingServiceTypeText;
  List<BookingResultsModel>? bookingResults;
  bool? allowUpdate;

  BookingServiceModel({
    this.bookingServiceId,
    this.bookingId,
    this.serviceId,
    this.staffId,
    this.serviceName,
    this.servicePrice,
    this.staffName,
    this.staffPhone,
    this.startAppointment,
    this.actualStartAppointment,
    this.endAppointment,
    this.actualEndAppointment,
    this.duration,
    this.durationText,
    this.bookingServiceStatus,
    this.professional,
    this.allowUpdate,
    this.bookingServiceType,
    this.bookingServiceTypeText,
    this.bookingResults,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'staffId': staffId,
      'startAppointment': startAppointment,
      'endAppointment': endAppointment,
    };
  }

  factory BookingServiceModel.fromJson(Map<String, dynamic> json) {
    return BookingServiceModel(
      bookingServiceId: json['bookingServiceId'],
      bookingId: json['bookingId'],
      serviceId: json['serviceId'],
      staffId: json['staffId'],
      serviceName: json['serviceName'],
      servicePrice: json['servicePrice'],
      staffName: json['staffName'],
      staffPhone: json['staffPhone'],
      startAppointment: json['startAppointment'],
      actualStartAppointment: json['actualStartAppointment'],
      endAppointment: json['endAppointment'],
      actualEndAppointment: json['actualEndAppointment'],
      duration: json['duration'],
      durationText: json['durationText'],
      bookingServiceStatus: json['bookingServiceStatus'],
      professional: json['professional'],
      allowUpdate: json['allowUpdate'],
      bookingServiceType: json['bookingServiceType'],
      bookingServiceTypeText: json['bookingServiceTypeText'],
      bookingResults: json['bookingResults'] != null
          ? ((json['bookingResults'] as List)
              .map((e) => BookingResultsModel.fromJson(e))
              .toList())
          : null,
    );
  }
}

class BookingResultsModel {
  int? bookingResultId;
  int? bookingServiceId;
  String? bookingResultImg;
  BookingResultsModel({
    this.bookingResultId,
    this.bookingServiceId,
    this.bookingResultImg,
  });
  factory BookingResultsModel.fromJson(Map<String, dynamic> json) {
    return BookingResultsModel(
      bookingResultId: json['bookingResultId'],
      bookingServiceId: json['bookingServiceId'],
      bookingResultImg: json['bookingResultImg'],
    );
  }
}

class BookingResultImgsModel {
  List<String> bookingResultImgs;
  BookingResultImgsModel({
    required this.bookingResultImgs,
  });
  Map<String, dynamic> toJson() {
    return {'bookingResultImgs': bookingResultImgs};
  }
}
