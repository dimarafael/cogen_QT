#ifndef MODBUS_H
#define MODBUS_H

#include <QThread>
#include <QModbusTcpClient>
#include <QVariant>

class modbus : public QThread
{
    Q_OBJECT
    void run();
public:
    explicit modbus(QObject *parent = nullptr);

signals:
    void updateData(QVector<quint16> data);
    void updateConnectedState(bool connected);
};

#endif // MODBUS_H
