import "package:license/res/types.dart";

Map<String, List<SignData>> _signsData = {
  "Mandatory Signs": [
    SignData(
      title: 'Turn Left Prohibited',
      image: 'assets/images/turn-left-prohibited.png',
      description:
          'A "Turn Left Prohibited" sign, showing a left arrow with a red slash, indicates that left turns are not allowed at that location, enhancing traffic flow and safety.',
      header: 'Mandatory Signs',
    ),
    SignData(
      title: 'No Entry',
      image: 'assets/images/no-entry-traffic.png',
      description:
          'A "No Entry" traffic sign, usually a red circle with a white horizontal bar, indicates that vehicles are not allowed to enter the roadway beyond the sign, ensuring restricted access for safety and traffic management.',
      header: 'Mandatory Signs',
    ),
    SignData(
      title: "Stop",
      image: "assets/images/stop.png",
      description:
          "A 'Stop' sign, usually a red octagon with white letters, indicates that drivers must come to a complete stop at the intersection, ensuring safety and traffic flow.",
      header: "Mandatory Signs",
    ),
    SignData(
      title: "Prohibited",
      image: "assets/images/prohibit.png",
      description:
          "A 'Prohibited' sign, usually a red circle with a red slash, indicates that certain actions or activities are not allowed in that area, ensuring safety and compliance with regulations.",
      header: "Mandatory Signs",
    ),
    SignData(
      title: "Speed Limit",
      image: "assets/images/speed_limit.png",
      description:
          "Indicates the maximum speed allowed on that road, ensuring safety and traffic flow.",
      header: "Mandatory Signs",
    ),
    SignData(
      title: "No Stopping",
      image: "assets/images/no-stopping.png",
      description:
          "Indicates that vehicles are not allowed to stop at that location, ensuring traffic flow and safety.",
      header: "Mandatory Signs",
    ),
    SignData(
      title: "U Turn Prohibit",
      image: "assets/images/u-turn-prohibit.png",
      description:
          "Indicates that U-turns are not allowed at that location, ensuring safety and traffic flow.",
      header: "Mandatory Signs",
    ),
  ],
  "Cautionary Signs": [
    SignData(
      title: 'Left Reverse Bend',
      image: 'assets/images/left-reverse-bend.png',
      description:
          'Indicates a left reverse bend ahead, ensuring safety and traffic flow.',
      header: 'Cautionary Signs',
    ),
    SignData(
      title: 'Narrow Bridge',
      image: 'assets/images/narrow-road-ahead.png',
      description:
          'Indicates that a narrow bridge is ahead, ensuring safety and traffic flow.',
      header: 'Cautionary Signs',
    ),
    SignData(
      title: "Side Road Right",
      image: "assets/images/side-road-right.png",
      description:
          "Indicates that a side road is approaching from the right, ensuring safety and traffic flow.",
      header: "Cautionary Signs",
    ),
    SignData(
      title: "Cross Road",
      image: "assets/images/cross-road.png",
      description:
          "Indicates that a cross road is ahead, ensuring safety and traffic flow.",
      header: "Cautionary Signs",
    ),
    SignData(
      title: "T-Insection",
      image: "assets/images/t-intersection.png",
      description:
          "Indicates that a T-intersection is ahead, ensuring safety and traffic flow.",
      header: "Cautionary Signs",
    ),
    SignData(
      title: "Men at Work",
      image: "assets/images/men-at-work.png",
      description:
          "Indicates that there are workers on the road ahead, ensuring safety and caution.",
      header: "Cautionary Signs",
    ),
    SignData(
      title: "Falling Rocks",
      image: "assets/images/falling-rocks.png",
      description:
          "Indicates that there is a risk of falling rocks ahead, ensuring safety and caution.",
      header: "Cautionary Signs",
    ),
  ],
  "Informatory Signs": [
    SignData(
      title: 'Hospital',
      image: 'assets/images/hospital.png',
      description: 'A nearby hospital',
      header: 'Informatory Signs',
    ),
    SignData(
      title: 'Narrow Bridge',
      image: 'assets/images/fuel-station.png',
      description: 'Petrol Pump',
      header: 'Informatory Signs',
    ),
    SignData(
      title: "Public Telephone",
      image: "assets/images/public-telephone.png",
      description: "Indicates that a public telephone is available nearby.",
      header: "Informatory Signs",
    ),
    SignData(
      title: "First Aid",
      image: "assets/images/first-aid.png",
      description: "Indicates that first aid is available nearby.",
      header: "Informatory Signs",
    ),
  ],
};

Map<String, List<SignData>> get signsData => _signsData;
