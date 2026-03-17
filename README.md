# AutoTorqueWrenchDrill

A professional-grade automated torque wrench system for precision automotive assembly. This application provides automatic torque application with real-time feedback, hardware communication, and comprehensive calibration for all torque specifications and socket sizes used in modern automotive work.

## Features

- **Automatic Torque Application**: Cordless drill-like operation with precise torque control
- **Universal Compatibility**: Support for all standard metric and SAE torque specifications (0.1 - 250+ N⋅m)
- **Hardware Integration**: Real-time communication with torque sensor hardware and motor controller
- **Calibration Management**: Built-in calibration routines for sensor accuracy
- **Work Logging**: Complete history of all torque applications with timestamps and verification
- **Safety Features**: Over-torque prevention, low battery alerts, hardware diagnostics
- **Multi-User Support**: Individual profiles and audit trails
- **Cross-Platform**: Works on Windows, macOS, and Linux systems

## System Architecture

```
AutoTorqueWrenchDrill/
├── src/
│   ├── hardware/          # Hardware communication layer
│   ├── control/           # Motor and torque control logic
│   ├── calibration/       # Sensor calibration routines
│   ├── ui/                # User interface
│   └── logging/           # Work logging and telemetry
├── tests/                 # Unit and integration tests
├── docs/                  # Technical documentation
├── config/                # Configuration templates
└── firmware/              # Embedded hardware firmware (if applicable)
```

## Quick Start

### Prerequisites
- Python 3.8 or higher
- USB communication drivers (see [Hardware Setup](docs/HARDWARE_SETUP.md))
- Compatible torque wrench hardware (see [Hardware Requirements](docs/HARDWARE_REQUIREMENTS.md))

### Installation

```bash
# Clone the repository
git clone https://github.com/jmvbogo/AutoTorqueWrenchDrill.git
cd AutoTorqueWrenchDrill

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the application
python -m autotorquewrench
```

## Usage

### Basic Operation

```python
from autotorquewrench import TorqueWrench

# Initialize wrench
wrench = TorqueWrench(port='/dev/ttyUSB0')  # USB connection

# Set torque specification (in N⋅m)
wrench.set_target_torque(25.0)

# Apply torque (automatic operation)
result = wrench.apply_torque()

if result.success:
    print(f"Applied: {result.actual_torque} N⋅m")
    print(f"Status: {result.status}")
else:
    print(f"Error: {result.error_message}")

wrench.close()
```

### Calibration

```python
from autotorquewrench import Calibration

cal = Calibration()
cal.run_sensor_calibration()
cal.verify_accuracy()
cal.save_calibration()
```

## Hardware Communication Protocol

The system communicates with hardware via USB serial connection using a custom binary protocol. See [Protocol Specification](docs/PROTOCOL.md) for detailed information.

### Supported Hardware
- **Motor Controller**: PWM-based stepper/brushless motor interface
- **Torque Sensor**: Load cell with 24-bit ADC interface
- **Safety Systems**: Emergency stop button, limit switches

## Documentation

- [Hardware Setup Guide](docs/HARDWARE_SETUP.md)
- [Hardware Requirements](docs/HARDWARE_REQUIREMENTS.md)
- [Communication Protocol](docs/PROTOCOL.md)
- [Calibration Guide](docs/CALIBRATION.md)
- [User Manual](docs/USER_MANUAL.md)
- [API Reference](docs/API_REFERENCE.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## Development

### Running Tests

```bash
pytest tests/ -v
```

### Building Documentation

```bash
cd docs
make html
```

## Safety Warnings ⚠️

- **Proper Training Required**: Operators must understand automotive torque specifications before use
- **Hardware Safety**: Always perform hardware self-tests before operation
- **Calibration Critical**: Regular calibration is required for safety-critical applications
- **Emergency Stop**: Familiarize yourself with emergency stop procedures
- **Liability**: Users assume all responsibility for proper usage in automotive assembly

## Compliance

This system is designed for professional automotive use. Verify compliance with your local automotive standards and regulations before deployment.

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## Support

- **Issue Tracker**: [GitHub Issues](https://github.com/jmvbogo/AutoTorqueWrenchDrill/issues)
- **Documentation**: See `/docs` directory
- **Email Support**: contact@autotorquewrench.dev (future)

## Version

Current Version: **1.0.0-beta**  
Last Updated: March 2026

## Disclaimer

This software is provided as-is for professional automotive assembly use. Users are responsible for:
- Understanding automotive torque specifications
- Proper hardware calibration and maintenance
- Compliance with automotive safety standards
- Training and certification of operators

Improper use could result in assembly failures or safety hazards.

---

**AutoTorqueWrenchDrill** © 2026 - Precision Engineering for Automotive Assembly
