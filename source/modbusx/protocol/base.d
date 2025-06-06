///
module modbusx.protocol.base;

public import std.bitmanip : BitArray;
public import std.exception : enforce;
public import std.datetime.stopwatch;
public import std.conv : to;

version (modbus_verbose)
    public import std.experimental.logger;

public import modbusx.exception;
public import modbusx.connection;
public import modbusx.backend;
public import modbusx.types;
public import modbusx.func;

///
abstract class Modbus
{
protected:
    void[MAX_BUFFER] buffer;

    Backend be;
    Connection con;
public:

    ///
    this(Backend be, Connection con)
    {
        if (be is null) throwModbusException("backend is null");
        if (con is null) throwModbusException("connection is null");
        this.be = be;
        this.con = con;
    }

    ///
    Backend backend() @property { return be; }
    ///
    Connection connection() @property { return con; }

    /++ Write to serial port

        Params:
            dev = modbus device address (number)
            fnc = function number
            args = writed data in native endian
        Returns:
            sended message
     +/
    const(void)[] write(Args...)(ulong dev, ubyte fnc, Args args)
    {
        auto buf = be.buildMessage(buffer, dev, fnc, 0, args);
        con.write(buf);
        return buf;
    }

    // ditto
    const(void)[] writeS(Args...)(ulong dev, ubyte fnc, ulong stamp, Args args)
    {
        auto buf = be.buildMessage(buffer, dev, fnc, stamp, args);
        con.write(buf);
        return buf;
    }
}