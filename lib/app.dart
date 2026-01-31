import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/battery/battery_bloc.dart';
import 'package:device_info/blocs/device/device_bloc.dart';
import 'package:device_info/blocs/storage/storage_bloc.dart';
import 'package:device_info/blocs/system/system_bloc.dart';
import 'package:device_info/blocs/connectivity/connectivity_bloc.dart';
import 'package:device_info/blocs/sensors/sensors_bloc.dart';
import 'package:device_info/blocs/location/location_bloc.dart';
import 'package:device_info/data/repositories/battery_repository.dart';
import 'package:device_info/data/repositories/device_repository.dart';
import 'package:device_info/data/repositories/storage_repository.dart';
import 'package:device_info/data/repositories/system_repository.dart';
import 'package:device_info/data/repositories/connectivity_repository.dart';
import 'package:device_info/data/repositories/sensors_repository.dart';
import 'package:device_info/data/repositories/location_repository.dart';
import 'package:device_info/services/platform_channels/battery_channel.dart';
import 'package:device_info/services/platform_channels/device_channel.dart';
import 'package:device_info/services/platform_channels/storage_channel.dart';
import 'package:device_info/services/platform_channels/system_channel.dart';
import 'package:device_info/services/platform_channels/connectivity_channel.dart';
import 'package:device_info/services/platform_channels/sensors_channel.dart';
import 'package:device_info/services/platform_channels/location_channel.dart';
import 'package:device_info/presentation/screens/home_screen.dart';
import 'package:device_info/utils/app_theme.dart';

class DeviceInfoApp extends StatelessWidget {
  const DeviceInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BatteryRepository>(
          create: (context) => BatteryRepository(BatteryChannel()),
        ),
        RepositoryProvider<DeviceRepository>(
          create: (context) => DeviceRepository(DeviceChannel()),
        ),
        RepositoryProvider<StorageRepository>(
          create: (context) => StorageRepository(StorageChannel()),
        ),
        RepositoryProvider<SystemRepository>(
          create: (context) => SystemRepository(SystemChannel()),
        ),
        RepositoryProvider<ConnectivityRepository>(
          create: (context) => ConnectivityRepository(ConnectivityChannel()),
        ),
        RepositoryProvider<SensorsRepository>(
          create: (context) => SensorsRepository(SensorsChannel()),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepository(LocationChannel()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                BatteryBloc(context.read<BatteryRepository>())
                  ..add(LoadBatteryInfo()),
          ),
          BlocProvider(
            create: (context) =>
                DeviceBloc(context.read<DeviceRepository>())
                  ..add(LoadDeviceInfo()),
          ),
          BlocProvider(
            create: (context) =>
                StorageBloc(context.read<StorageRepository>())
                  ..add(LoadStorageInfo()),
          ),
          BlocProvider<SystemBloc>(
            create: (context) =>
                SystemBloc(context.read<SystemRepository>())
                  ..add(LoadSystemInfo()),
          ),
          BlocProvider<ConnectivityBloc>(
            create: (context) =>
                ConnectivityBloc(context.read<ConnectivityRepository>())
                  ..add(LoadConnectivityInfo()),
          ),
          BlocProvider<SensorsBloc>(
            create: (context) =>
                SensorsBloc(context.read<SensorsRepository>())
                  ..add(LoadSensorsInfo()),
          ),
          BlocProvider<LocationBloc>(
            create: (context) =>
                LocationBloc(context.read<LocationRepository>())
                  ..add(LoadLocationInfo()),
          ),
        ],
        child: MaterialApp(
          title: 'Device Info',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
