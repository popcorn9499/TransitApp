// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transit_app/api/DataModels/bus_stop.dart';
import 'package:transit_app/api/DataModels/bus_info.dart';
import 'package:transit_app/api/DataModels/bus_stop_schedules.dart';
import 'package:transit_app/api/DataModels/route.dart';
import 'package:transit_app/api/DataModels/variant.dart';
import 'package:transit_app/api/TransitManager.dart';

void main() {
  test('Test BusStopSchedules Creation', () async {

    BusStop busStop =
    BusStop(key: 1234, number: 1234, name: "cool stop", direction: "South", distance: -1);
    Route route = Route(
        name: "cool super name",
        number: "123",
        key: "123",
        variantKeys: ["123", "hello"],
        borderColor: "#FFFFFF");
    Variant variant = Variant(name: "cool super name 123", key: "123");
    BusInfo busInfo = BusInfo(
        stop: busStop,
        route: route,
        bikeRack: false,
        wifi: false,
        cancelled: false,
        busNumber: 666,
        arrivalEstimated: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        arrivalScheduled: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        departureEstimated: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        departureScheduled: TransitManager.apiDateFormat.parse("2022-12-19T19:44:50"),
        variant: variant);
    List<BusInfo> busInfoList = <BusInfo>[];

    busInfoList.add(busInfo);

    BusStopSchedules bss = BusStopSchedules(schedules: busInfoList, busStop: busStop);


    //check name variable
    expect(bss.busStop, equals(busStop), reason: "ensure the bus stop is correctly saved");
    expect(bss.schedules, equals(busInfoList), reason: "ensure the bus schedules is correctly saved");

  });

  test('Test BusStopSchedules fromJson', () async {
    Map<String, dynamic>  input = {
      "stop-schedule": {
        "stop": {
          "key": 10611,
          "name": "EB Graham@Fort (Wpg Square)",
          "number": 10611,
          "direction": "Eastbound",
          "side": "Nearside",
          "street": {
            "key": 1533,
            "name": "GrahamAve",
            "type": "Avenue"
          },
          "cross-street": {
            "key": 1365,
            "name": "FortSt",
            "type": "Street"
          },
          "centre": {
            "utm": {
              "zone": "14U",
              "x": 633667,
              "y": 5528384
            },
            "geographic": {
              "latitude": "49.8929",
              "longitude": "-97.13897"
            }
          }
        },
        "route-schedules": [
          {
            "route": {
              "key": 44,
              "number": 44,
              "name": "Grey",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 44,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22346834-9",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:11:44",
                    "estimated": "2022-12-12T23:11:44"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:11:44",
                    "estimated": "2022-12-12T23:11:44"
                  }
                },
                "variant": {
                  "key": "44-0-L",
                  "name": "KP via London"
                },
                "bus": {
                  "key": 165,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22346835-9",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:41:44",
                    "estimated": "2022-12-12T23:41:44"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:41:44",
                    "estimated": "2022-12-12T23:41:44"
                  }
                },
                "variant": {
                  "key": "44-0-M",
                  "name": "KP via Louelda"
                },
                "bus": {
                  "key": 577,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22346836-9",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:10:44",
                    "estimated": "2022-12-13T00:10:44"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:10:44",
                    "estimated": "2022-12-13T00:10:44"
                  }
                },
                "variant": {
                  "key": "44-0-L",
                  "name": "KP via London"
                },
                "bus": {
                  "key": 633,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22346837-9",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:39:44",
                    "estimated": "2022-12-13T00:39:44"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:39:44",
                    "estimated": "2022-12-13T00:39:44"
                  }
                },
                "variant": {
                  "key": "44-0-M",
                  "name": "KP via Louelda"
                },
                "bus": {
                  "key": 165,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22346838-9",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:07:44",
                    "estimated": "2022-12-13T01:07:44"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:07:44",
                    "estimated": "2022-12-13T01:07:44"
                  }
                },
                "variant": {
                  "key": "44-0-L",
                  "name": "KP via London"
                },
                "bus": {
                  "key": 577,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22346839-9",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:36:44",
                    "estimated": "2022-12-13T01:36:44"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:36:44",
                    "estimated": "2022-12-13T01:36:44"
                  }
                },
                "variant": {
                  "key": "44-0-M",
                  "name": "KP via Louelda"
                },
                "bus": {
                  "key": 633,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": 33,
              "number": 33,
              "name": "Maples",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 33,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22350834-61",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:16:40",
                    "estimated": "2022-12-12T23:18:01"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:16:40",
                    "estimated": "2022-12-12T23:18:01"
                  }
                },
                "variant": {
                  "key": "33-1-D2",
                  "name": "to Downtown"
                },
                "bus": {
                  "key": 118,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22350838-60",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:44:02",
                    "estimated": "2022-12-12T23:44:02"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:44:02",
                    "estimated": "2022-12-12T23:44:02"
                  }
                },
                "variant": {
                  "key": "33-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 629,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22350841-61",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:12:02",
                    "estimated": "2022-12-13T00:12:02"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:12:02",
                    "estimated": "2022-12-13T00:12:02"
                  }
                },
                "variant": {
                  "key": "33-1-D2",
                  "name": "to Downtown"
                },
                "bus": {
                  "key": 402,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350840-60",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:39:02",
                    "estimated": "2022-12-13T00:39:02"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:39:02",
                    "estimated": "2022-12-13T00:39:02"
                  }
                },
                "variant": {
                  "key": "33-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 118,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22350843-61",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:05:02",
                    "estimated": "2022-12-13T01:05:02"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:05:02",
                    "estimated": "2022-12-13T01:05:02"
                  }
                },
                "variant": {
                  "key": "33-1-D2",
                  "name": "to Downtown"
                },
                "bus": {
                  "key": 629,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22350845-60",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:31:02",
                    "estimated": "2022-12-13T01:31:02"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:31:02",
                    "estimated": "2022-12-13T01:31:02"
                  }
                },
                "variant": {
                  "key": "33-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 402,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": 45,
              "number": 45,
              "name": "Talbot",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 45,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22346960-7",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:04:47",
                    "estimated": "2022-12-12T23:04:16"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:04:47",
                    "estimated": "2022-12-12T23:04:16"
                  }
                },
                "variant": {
                  "key": "45-0-K",
                  "name": "Kildonan Place"
                },
                "bus": {
                  "key": 605,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22346935-7",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:42:47",
                    "estimated": "2022-12-12T23:42:47"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:42:47",
                    "estimated": "2022-12-12T23:42:47"
                  }
                },
                "variant": {
                  "key": "45-0-K",
                  "name": "Kildonan Place"
                },
                "bus": {
                  "key": 865,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22346955-7",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:21:47",
                    "estimated": "2022-12-13T00:21:47"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:21:47",
                    "estimated": "2022-12-13T00:21:47"
                  }
                },
                "variant": {
                  "key": "45-0-K",
                  "name": "Kildonan Place"
                },
                "bus": {
                  "key": 605,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22346956-7",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:36:47",
                    "estimated": "2022-12-13T01:36:47"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:36:47",
                    "estimated": "2022-12-13T01:36:47"
                  }
                },
                "variant": {
                  "key": "45-0-K",
                  "name": "Kildonan Place"
                },
                "bus": {
                  "key": 605,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": "BLUE",
              "number": "BLUE",
              "customer-type": "regular",
              "coverage": "rapid transit",
              "badge-label": "B",
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "rapid-transit"
                  ]
                },
                "background-color": "#0060a9",
                "border-color": "#0060a9",
                "color": "#ffffff"
              }
            },
            "scheduled-stops": [
              {
                "key": "22350537-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:07:13",
                    "estimated": "2022-12-12T23:07:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:07:13",
                    "estimated": "2022-12-12T23:07:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-S",
                  "name": "st. norbert"
                },
                "bus": {
                  "key": 372,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350538-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:21:13",
                    "estimated": "2022-12-12T23:21:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:21:13",
                    "estimated": "2022-12-12T23:21:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-U",
                  "name": "UM"
                },
                "bus": {
                  "key": 333,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22350539-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:35:13",
                    "estimated": "2022-12-12T23:35:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:35:13",
                    "estimated": "2022-12-12T23:35:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-S",
                  "name": "st. norbert"
                },
                "bus": {
                  "key": 397,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350540-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:49:13",
                    "estimated": "2022-12-12T23:49:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:49:13",
                    "estimated": "2022-12-12T23:49:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-U",
                  "name": "UM"
                },
                "bus": {
                  "key": 379,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350541-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:03:13",
                    "estimated": "2022-12-13T00:03:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:03:13",
                    "estimated": "2022-12-13T00:03:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-S",
                  "name": "st. norbert"
                },
                "bus": {
                  "key": 386,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350542-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:17:13",
                    "estimated": "2022-12-13T00:17:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:17:13",
                    "estimated": "2022-12-13T00:17:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-U",
                  "name": "UM"
                },
                "bus": {
                  "key": 371,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350543-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:30:13",
                    "estimated": "2022-12-13T00:30:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:30:13",
                    "estimated": "2022-12-13T00:30:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-S",
                  "name": "st. norbert"
                },
                "bus": {
                  "key": 372,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350544-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:44:13",
                    "estimated": "2022-12-13T00:44:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:44:13",
                    "estimated": "2022-12-13T00:44:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-U",
                  "name": "UM"
                },
                "bus": {
                  "key": 333,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22350545-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:57:13",
                    "estimated": "2022-12-13T00:57:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:57:13",
                    "estimated": "2022-12-13T00:57:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-S",
                  "name": "st. norbert"
                },
                "bus": {
                  "key": 397,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350546-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:11:13",
                    "estimated": "2022-12-13T01:11:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:11:13",
                    "estimated": "2022-12-13T01:11:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-U",
                  "name": "UM"
                },
                "bus": {
                  "key": 379,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350547-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:25:13",
                    "estimated": "2022-12-13T01:25:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:25:13",
                    "estimated": "2022-12-13T01:25:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-S",
                  "name": "st. norbert"
                },
                "bus": {
                  "key": 386,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22350548-8",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:40:13",
                    "estimated": "2022-12-13T01:40:13"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:40:13",
                    "estimated": "2022-12-13T01:40:13"
                  }
                },
                "variant": {
                  "key": "BLUE-0-U",
                  "name": "UM"
                },
                "bus": {
                  "key": 371,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": 16,
              "number": 16,
              "name": "Selkirk-Osborne",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 16,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22344952-37",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:25:20",
                    "estimated": "2022-12-12T23:25:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:25:20",
                    "estimated": "2022-12-12T23:25:20"
                  }
                },
                "variant": {
                  "key": "16-0-M",
                  "name": "Via Manitoba"
                },
                "bus": {
                  "key": 823,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22344953-35",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:51:20",
                    "estimated": "2022-12-12T23:51:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:51:20",
                    "estimated": "2022-12-12T23:51:20"
                  }
                },
                "variant": {
                  "key": "16-0-B",
                  "name": "Via Burrows"
                },
                "bus": {
                  "key": 348,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22344941-37",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:16:20",
                    "estimated": "2022-12-13T00:16:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:16:20",
                    "estimated": "2022-12-13T00:16:20"
                  }
                },
                "variant": {
                  "key": "16-0-M",
                  "name": "Via Manitoba"
                },
                "bus": {
                  "key": 342,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22344940-35",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:42:20",
                    "estimated": "2022-12-13T00:42:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:42:20",
                    "estimated": "2022-12-13T00:42:20"
                  }
                },
                "variant": {
                  "key": "16-0-B",
                  "name": "Via Burrows"
                },
                "bus": {
                  "key": 432,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22344936-37",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:09:20",
                    "estimated": "2022-12-13T01:09:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:09:20",
                    "estimated": "2022-12-13T01:09:20"
                  }
                },
                "variant": {
                  "key": "16-0-M",
                  "name": "Via Manitoba"
                },
                "bus": {
                  "key": 146,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22344935-35",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:36:20",
                    "estimated": "2022-12-13T01:36:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:36:20",
                    "estimated": "2022-12-13T01:36:20"
                  }
                },
                "variant": {
                  "key": "16-0-*",
                  "name": "Selkrk\u0026McPhil"
                },
                "bus": {
                  "key": 823,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": 17,
              "number": 17,
              "name": "McGregor",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 17,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22345149-17",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:23:53",
                    "estimated": "2022-12-12T23:23:53"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:23:53",
                    "estimated": "2022-12-12T23:23:53"
                  }
                },
                "variant": {
                  "key": "17-0-S",
                  "name": "Seven Oaks Hosp"
                },
                "bus": {
                  "key": 434,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22345150-17",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:51:53",
                    "estimated": "2022-12-12T23:51:53"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:51:53",
                    "estimated": "2022-12-12T23:51:53"
                  }
                },
                "variant": {
                  "key": "17-0-S",
                  "name": "Seven Oaks Hosp"
                },
                "bus": {
                  "key": 170,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345151-17",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:18:53",
                    "estimated": "2022-12-13T00:18:53"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:18:53",
                    "estimated": "2022-12-13T00:18:53"
                  }
                },
                "variant": {
                  "key": "17-0-S",
                  "name": "Seven Oaks Hosp"
                },
                "bus": {
                  "key": 324,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345081-17",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:44:53",
                    "estimated": "2022-12-13T00:44:53"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:44:53",
                    "estimated": "2022-12-13T00:44:53"
                  }
                },
                "variant": {
                  "key": "17-0-S",
                  "name": "Seven Oaks Hosp"
                },
                "bus": {
                  "key": 434,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22345082-17",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:11:53",
                    "estimated": "2022-12-13T01:11:53"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:11:53",
                    "estimated": "2022-12-13T01:11:53"
                  }
                },
                "variant": {
                  "key": "17-0-S",
                  "name": "Seven Oaks Hosp"
                },
                "bus": {
                  "key": 170,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345079-17",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:36:53",
                    "estimated": "2022-12-13T01:36:53"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:36:53",
                    "estimated": "2022-12-13T01:36:53"
                  }
                },
                "variant": {
                  "key": "17-0-S",
                  "name": "Seven Oaks Hosp"
                },
                "bus": {
                  "key": 324,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": 18,
              "number": 18,
              "name": "North Main-Corydon",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 18,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22345398-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:12:20",
                    "estimated": "2022-12-12T23:12:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:12:20",
                    "estimated": "2022-12-12T23:12:20"
                  }
                },
                "variant": {
                  "key": "18-0-R",
                  "name": "Riverbend"
                },
                "bus": {
                  "key": 866,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345399-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:34:20",
                    "estimated": "2022-12-12T23:34:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:34:20",
                    "estimated": "2022-12-12T23:34:20"
                  }
                },
                "variant": {
                  "key": "18-0-J",
                  "name": "Garden City"
                },
                "bus": {
                  "key": 858,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345400-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:56:20",
                    "estimated": "2022-12-12T23:56:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:56:20",
                    "estimated": "2022-12-12T23:56:20"
                  }
                },
                "variant": {
                  "key": "18-0-R",
                  "name": "Riverbend"
                },
                "bus": {
                  "key": 168,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22345401-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:18:20",
                    "estimated": "2022-12-13T00:18:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:18:20",
                    "estimated": "2022-12-13T00:18:20"
                  }
                },
                "variant": {
                  "key": "18-0-J",
                  "name": "Garden City"
                },
                "bus": {
                  "key": 825,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345402-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:39:20",
                    "estimated": "2022-12-13T00:39:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:39:20",
                    "estimated": "2022-12-13T00:39:20"
                  }
                },
                "variant": {
                  "key": "18-0-R",
                  "name": "Riverbend"
                },
                "bus": {
                  "key": 330,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345403-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:59:20",
                    "estimated": "2022-12-13T00:59:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:59:20",
                    "estimated": "2022-12-13T00:59:20"
                  }
                },
                "variant": {
                  "key": "18-0-J",
                  "name": "Garden City"
                },
                "bus": {
                  "key": 866,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345404-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:18:20",
                    "estimated": "2022-12-13T01:18:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:18:20",
                    "estimated": "2022-12-13T01:18:20"
                  }
                },
                "variant": {
                  "key": "18-0-R",
                  "name": "Riverbend"
                },
                "bus": {
                  "key": 858,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345405-45",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:36:20",
                    "estimated": "2022-12-13T01:36:20"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:36:20",
                    "estimated": "2022-12-13T01:36:20"
                  }
                },
                "variant": {
                  "key": "18-0-T",
                  "name": "Templeton"
                },
                "bus": {
                  "key": 168,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": 60,
              "number": 60,
              "name": "Pembina",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 60,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22347610-53",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:10:41",
                    "estimated": "2022-12-12T23:11:48"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:10:41",
                    "estimated": "2022-12-12T23:11:48"
                  }
                },
                "variant": {
                  "key": "60-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 864,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22347611-53",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:45:57",
                    "estimated": "2022-12-12T23:45:57"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:45:57",
                    "estimated": "2022-12-12T23:45:57"
                  }
                },
                "variant": {
                  "key": "60-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 841,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22347612-53",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:18:57",
                    "estimated": "2022-12-13T00:18:57"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:18:57",
                    "estimated": "2022-12-13T00:18:57"
                  }
                },
                "variant": {
                  "key": "60-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 864,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22347613-53",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:51:12",
                    "estimated": "2022-12-13T00:51:12"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:51:12",
                    "estimated": "2022-12-13T00:51:12"
                  }
                },
                "variant": {
                  "key": "60-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 841,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22347614-53",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:25:57",
                    "estimated": "2022-12-13T01:25:57"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:25:57",
                    "estimated": "2022-12-13T01:25:57"
                  }
                },
                "variant": {
                  "key": "60-1-D",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 864,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              }
            ]
          },
          {
            "route": {
              "key": 20,
              "number": 20,
              "name": "Academy-Watt",
              "customer-type": "regular",
              "coverage": "regular",
              "badge-label": 20,
              "badge-style": {
                "class-names": {
                  "class-name": [
                    "badge-label",
                    "regular"
                  ]
                },
                "background-color": "#ffffff",
                "border-color": "#d9d9d9",
                "color": "#000000"
              }
            },
            "scheduled-stops": [
              {
                "key": "22345608-50",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-12T23:39:38",
                    "estimated": "2022-12-12T23:39:38"
                  },
                  "departure": {
                    "scheduled": "2022-12-12T23:39:38",
                    "estimated": "2022-12-12T23:39:38"
                  }
                },
                "variant": {
                  "key": "20-0-W",
                  "name": "Watt\u0026Leighton"
                },
                "bus": {
                  "key": 806,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345593-50",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:16:48",
                    "estimated": "2022-12-13T00:16:48"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:16:48",
                    "estimated": "2022-12-13T00:16:48"
                  }
                },
                "variant": {
                  "key": "20-0-W",
                  "name": "Watt\u0026Leighton"
                },
                "bus": {
                  "key": 140,
                  "bike-rack": "true",
                  "wifi": "false"
                }
              },
              {
                "key": "22345606-50",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T00:52:48",
                    "estimated": "2022-12-13T00:52:48"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T00:52:48",
                    "estimated": "2022-12-13T00:52:48"
                  }
                },
                "variant": {
                  "key": "20-0-F",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 636,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              },
              {
                "key": "22345604-50",
                "cancelled": "false",
                "times": {
                  "arrival": {
                    "scheduled": "2022-12-13T01:28:48",
                    "estimated": "2022-12-13T01:28:48"
                  },
                  "departure": {
                    "scheduled": "2022-12-13T01:28:48",
                    "estimated": "2022-12-13T01:28:48"
                  }
                },
                "variant": {
                  "key": "20-0-F",
                  "name": "Downtown"
                },
                "bus": {
                  "key": 806,
                  "bike-rack": "false",
                  "wifi": "false"
                }
              }
            ]
          }
        ]
      },
      "query-time": "2022-12-12T23:03:37"
    };

    BusStopSchedules bss = BusStopSchedules.fromJson(input);
    if (kDebugMode) {
      print(bss.busStop.toString());
    }
    if (kDebugMode) {
      print(bss.schedules[0].toString());
    }
    if (kDebugMode) {
      print(bss.schedules.length);
    }
    expect(bss.busStop.toString(), equals("Stop #10611 at EB Graham@Fort (Wpg Square) direction Eastbound"));
    expect(bss.schedules[0].toString(), equals("Bus Route name: Talbot key: 45 number: 45 variants:]arrival scheduled: 2022-12-12T23:04:47 arrival estimated: 2022-12-12T23:04:16 departure scheduled 2022-12-12T23:04:47 departure estimated 2022-12-12T23:04:16 45-0-K: Kildonan Place at stop Stop #10611 at EB Graham@Fort (Wpg Square) direction Eastbound"));
    expect(bss.schedules.length, equals(57));
  });
}


bool compareList(List<dynamic> list, List<dynamic> other){
  bool result = true;
  if (list.length != other.length) {
    result = false;
  }

  for (var element in list) {
    if (!other.contains(element)){
      result = false;
    }
  }

  return result;
}
