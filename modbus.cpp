#include "modbus.h"
#include <QTimer>

void modbus::run()
{
    QModbusTcpClient mc;
    QTimer timer;
    timer.start(1000);
    QVector<quint16> vData(4);
    QModbusDataUnit du(QModbusDataUnit::HoldingRegisters,0,vData);
    QModbusReply *reply;

    auto reply_result = [&](){
        if(!reply->error()){
            emit updateData(reply->result().values());
        }
        reply->deleteLater();
    };

    // Timer timeout function
    auto timeout = [&](){
        if(mc.state() == QModbusDevice::ConnectedState){
            reply = mc.sendReadRequest(du,1);
            if(reply->isFinished()){
                delete reply;
            } else{
                connect(reply, &QModbusReply::finished, reply_result);
            }
        } else if (mc.state() == QModbusDevice::UnconnectedState){
            mc.connectDevice();
        }
    };
    connect(&timer, &QTimer::timeout, timeout);

    //ModbusClient state changed
    auto stateChanged = [&](QModbusClient::State state){

    };
    connect(&mc, &QModbusClient::stateChanged, stateChanged);



    mc.setConnectionParameter(QModbusDevice::NetworkAddressParameter, "127.0.0.1");
    mc.setConnectionParameter(QModbusDevice::NetworkPortParameter, 502);
    mc.connectDevice();


    exec();
}

modbus::modbus(QObject *parent) : QThread(parent){ }

