#include "modbus.h"

modbus::modbus(){
    mc = new QModbusTcpClient(this);
    // mc->setConnectionParameter(QModbusDevice::NetworkAddressParameter, "127.0.0.1");
    mc->setConnectionParameter(QModbusDevice::NetworkAddressParameter, "192.168.1.42");
    mc->setConnectionParameter(QModbusDevice::NetworkPortParameter, 502);
    timer = new QTimer(this);
    vData = new QVector<quint16>(100);
    du = new QModbusDataUnit(QModbusDataUnit::HoldingRegisters,99,*vData);
    connect(mc, &QModbusClient::stateChanged, this, &modbus::processStateChanged);
}

modbus::~modbus(){
    if(mc) {
        mc->disconnect();
        // delete mc;
        mc->deleteLater();
    }
}

// starts in thread
void modbus::pollModbus(){
    mc->connectDevice();
    timer->start(1000);
    connect(timer, &QTimer::timeout, this, &modbus::timerTimeout);
}

//Query result processing
void modbus::processReplyResult()
{
    auto reply = qobject_cast<QModbusReply *>(sender());
    if (!reply)
        return;

    if(!reply->error()){
        emit updateData(reply->result().values());
    }
    reply->deleteLater();
}

//ModbusClient state changed
void modbus::processStateChanged(QModbusClient::State state)
{
    if(mc->state() == QModbusDevice::ConnectedState){
        emit updateConnectedState(true);
    } else{
        emit updateConnectedState(false);
    }
}

// Timer timeout function
void modbus::timerTimeout()
{
    if(mc->state() == QModbusDevice::ConnectedState){
        auto *reply = mc->sendReadRequest(*du,1);
        if(reply->isFinished()){
            delete reply;
        } else{
            connect(reply, &QModbusReply::finished, this, &modbus::processReplyResult);
        }
    } else if (mc->state() == QModbusDevice::UnconnectedState){
        mc->connectDevice();
    }
}

float modbus::toFloat(quint16 low, quint16 high)
{
    quint32 joined = ((quint32)high<<16)|low;
    float f;
    memcpy(&f, &joined, sizeof f);
    return f;
}

quint16 modbus::floatToLowWord(float value)
{
    quint16 res;
    memcpy(&res ,&value ,2);
    return res;
}

quint16 modbus::floatToHighWord(float value)
{
    quint16 res;
    quint32 tmp32;
    memcpy(&tmp32, &value, sizeof tmp32);
    tmp32 = tmp32>>16;
    memcpy(&res ,&tmp32, 2);
    return res;
}

quint32 modbus::toUint32(quint16 low, quint16 high)
{
    quint32 joined = ((quint32)high<<16)|low;
    // quint32 res;
    // memcpy(&res, &joined, sizeof res);
    return joined;
}

void modbus::writeHoldingRegister(int addr, qint16 value){
    QVector<quint16> vDataWrite(1);
    vDataWrite[0] = value;
    QModbusDataUnit duForWrite(QModbusDataUnit::HoldingRegisters, addr, vDataWrite);
    mc->sendWriteRequest( duForWrite,1);
}

void modbus::writeFloatHolding(int addr, float value)
{
    QVector<quint16> vDataWrite(2);
    vDataWrite[0] = floatToLowWord(value);
    vDataWrite[1] = floatToHighWord(value);
    QModbusDataUnit duForWrite(QModbusDataUnit::HoldingRegisters, addr, vDataWrite);
    mc->sendWriteRequest( duForWrite,1);
}

