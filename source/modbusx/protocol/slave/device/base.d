///
module modbusx.protocol.slave.device.base;

public import modbusx.types;
public import modbusx.backend;
public import modbusx.protocol.slave.types;

///
interface ModbusSlaveDevice
{
    ///
    ulong number() @property;

    ///
    Response onMessage(ResponseWriter rw, ref const Message msg);
}