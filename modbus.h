#ifndef MODBUS_H
#define MODBUS_H

#include <QModbusTcpClient>
#include <QVariant>
#include <QTimer>

class modbus : public QObject
{
    Q_OBJECT
public:
//    explicit modbus(QObject *parent = nullptr);
    modbus();
    ~modbus();
    static float toFloat(quint16 low, quint16 high);
    static quint16 floatToLowWord(float value);
    static quint16 floatToHighWord(float value);

public slots:
    void writeHoldingRegister(int addr, qint16 value);
    void writeFloatHolding(int addr, float value);
    void pollModbus();

signals:
    void updateData(QVector<quint16> data);
    void updateConnectedState(bool connected);

private:
    QModbusTcpClient *mc = nullptr;
    QTimer *timer;
    QVector<quint16> *vData;
    QModbusDataUnit *du;
    void processReplyResult();
    void processStateChanged(QModbusClient::State state);
    void timerTimeout();
};

#endif // MODBUS_H
