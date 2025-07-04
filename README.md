# Fork

This is fork of [modbus library](https://github.com/deviator/modbus)

# Modbus

[![Build Status](https://travis-ci.org/deviator/modbusx.svg?branch=master)](https://travis-ci.org/deviator/modbus)
[![Build status](https://ci.appveyor.com/api/projects/status/pv75pbe12ho8ndwd?svg=true)](https://ci.appveyor.com/project/deviator/modbus)
[![codecov](https://codecov.io/gh/deviator/modbus/branch/master/graph/badge.svg)](https://codecov.io/gh/deviator/modbus)
[![Dub](https://img.shields.io/dub/v/modbusx.svg)](http://code.dlang.org/packages/modbus)
[![Downloads](https://img.shields.io/dub/dt/modbusx.svg)](http://code.dlang.org/packages/modbus)
[![License](https://img.shields.io/dub/l/modbusx.svg)](http://code.dlang.org/packages/modbus)

Library provides modbus wrapper over RTU and TCP connections.
Using [`serialportx`](https://github.com/deviator/serialportx) for RTU.

Simple usage:

```d
auto mbus = new ModbusRTUMaster("/dev/ttyUSB0", 19200);
mbus.readTimeout = 2.seconds;
writeln(mbus.readInputRegisters(1, 17, 1));
```

Implemented functions:

* 01 (0x01) `readCoils`
* 02 (0x02) `readDiscreteInputs`
* 03 (0x03) `readHoldingRegisters` (returns `const(ushort)[]` in native endian)
* 04 (0x04) `readInputRegisters` (return in native endian too)
* 05 (0x05) `writeSingleCoil`
* 06 (0x06) `writeSingleRegister`
* 16 (0x10) `writeMultipleRegisters`

If you need other function you can use it directly:

```d
auto res = mbus.request(dev, fnc, expectedDataLength, args);
```

where `args` is compile time variadic arguments, they convert
to big endian by element for sending inside lib. `res` returns
in big endian and you must convert to little endian by yourself.

And if you can test new function welcome to pull requests =)

For tcp connection using `std.socket.TcpSocket`.

```d
auto addr = "device_IP";
ushort port = 502; // or 503
auto mbs = new ModbusTCPMaster(new InternetAddress(addr, port));
writeln(mbs.readInputRegisters(1, 17, 1));
```

`ModbusRTUMaster` and `ModbusTCPMaster` close serial port and
socket in destructors.