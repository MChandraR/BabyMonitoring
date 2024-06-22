import 'package:flutter/material.dart';

enum DeviceRole { none, parent, baby }

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  DeviceRole _selectedRole = DeviceRole.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('History'),
            subtitle: const Text('Recorded events of the last 7 days'),
            leading: const Icon(Icons.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistorySettingView(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Lullabies'),
            subtitle: const Text('Manage recorded lullabies'),
            leading: const Icon(Icons.music_note),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LullabiesSettingView(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Paired devices'),
            subtitle: const Text('Pair another parent\'s device'),
            leading: const Icon(Icons.phonelink_ring),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PairedDevicesSettingView(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Device name'),
            subtitle: const Text('Android'),
            leading: const Icon(Icons.smartphone),
            onTap: () {
              // Handle device name setting
            },
          ),
          ListTile(
            title: Text('Default device role'),
            subtitle: Text(_selectedRole == DeviceRole.none
                ? 'None'
                : _selectedRole == DeviceRole.parent
                    ? 'Parent'
                    : 'Baby'),
            leading: const Icon(Icons.swap_horiz),
            onTap: () async {
              final selectedRole = await Navigator.push<DeviceRole>(
                context,
                MaterialPageRoute(
                  builder: (_) => const DeviceDefaultRole(),
                ),
              );
              if (selectedRole != null) {
                setState(() {
                  _selectedRole = selectedRole;
                });
              }
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: const Text('English'),
            leading: const Icon(Icons.language),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LanguageSettingView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HistorySettingView extends StatelessWidget {
  const HistorySettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History Settings')),
      body: const Center(child: Text('View and manage history settings')),
    );
  }
}

class LullabiesSettingView extends StatelessWidget {
  const LullabiesSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lullabies Settings')),
      body: const Center(child: Text('Manage your lullabies settings here')),
    );
  }
}

class PairedDevicesSettingView extends StatelessWidget {
  const PairedDevicesSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paired Devices Settings')),
      body: const Center(child: Text('Pair and manage devices')),
    );
  }
}

class LanguageSettingView extends StatefulWidget {
  const LanguageSettingView({Key? key}) : super(key: key);

  @override
  _LanguageSettingViewState createState() => _LanguageSettingViewState();
}

class _LanguageSettingViewState extends State<LanguageSettingView> {
  Locale _selectedLocale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    var S;
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).language)),
      body: Column(
        children: <Widget>[
          RadioListTile<Locale>(
            title: const Text('English'),
            value: const Locale('en'),
            groupValue: _selectedLocale,
            onChanged: (Locale? value) {
              setState(() {
                _selectedLocale = value!;
                var S;
                S.load(_selectedLocale);
              });
            },
          ),
          RadioListTile<Locale>(
            title: const Text('Bahasa Indonesia'),
            value: const Locale('id'),
            groupValue: _selectedLocale,
            onChanged: (Locale? value) {
              setState(() {
                _selectedLocale = value!;
                S.load(_selectedLocale);
              });
            },
          ),
        ],
      ),
    );
  }
}

class DeviceDefaultRole extends StatefulWidget {
  const DeviceDefaultRole({Key? key}) : super(key: key);

  @override
  _DeviceDefaultRoleState createState() => _DeviceDefaultRoleState();
}

class _DeviceDefaultRoleState extends State<DeviceDefaultRole> {
  DeviceRole? _role = DeviceRole.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default Device Role'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, _role);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('None'),
            leading: Radio<DeviceRole>(
              value: DeviceRole.none,
              groupValue: _role,
              onChanged: (DeviceRole? value) {
                setState(() {
                  _role = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                _role = DeviceRole.none;
              });
            },
          ),
          ListTile(
            title: const Text('Parent'),
            leading: Radio<DeviceRole>(
              value: DeviceRole.parent,
              groupValue: _role,
              onChanged: (DeviceRole? value) {
                setState(() {
                  _role = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                _role = DeviceRole.parent;
              });
            },
          ),
          ListTile(
            title: const Text('Baby'),
            leading: Radio<DeviceRole>(
              value: DeviceRole.baby,
              groupValue: _role,
              onChanged: (DeviceRole? value) {
                setState(() {
                  _role = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                _role = DeviceRole.baby;
              });
            },
          ),
        ],
      ),
    );
  }
}
