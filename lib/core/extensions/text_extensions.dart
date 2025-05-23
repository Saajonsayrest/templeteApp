extension StringExtension on String {
  String get capitalizeEachWord {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String get capitalizeEachLetter {
    if (isEmpty) {
      return this;
    }
    return toUpperCase();
  }
}


extension PhoneMaskExtension on String {
  String maskPhoneNumber() {
    if (length == 10) {
      return '${substring(0, 2)}xxxxxx${substring(length - 2)}';
    } else {
      return 'XX';
    }
  }
}

extension HumanizeString on String {
  String get humanize {
    return this.isEmpty
        ? ''
        : replaceAll('_', ' ') // Replace underscores with spaces
            .split(' ') // Split into words
            .map((word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : '')
            .join(' '); // Capitalize the first letter and join back
  }
}

extension SplitBeforeSpace on String {
  String get splitBeforeSpace {
    if (isEmpty) {
      return this;
    }
    return split(' ').first;
  }
}

extension CoordinatesExtension on String {
  String get firstCoordinate {
    if (isEmpty) {
      return ''; // Return an empty string if the input is empty
    }
    return split(',').first;
  }

  String get secondCoordinate {
    if (isEmpty) {
      return ''; // Return an empty string if the input is empty
    }
    final parts = split(',');
    return parts.length > 1 ? parts[1] : ''; // Return the second coordinate if available
  }
}


