import 'dart:io';

import 'package:flutter/foundation.dart';

bool isMobile = kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
