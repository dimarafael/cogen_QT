#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include "modbus.h"

class AppManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isButton1 READ isButton1 WRITE setIsButton1 NOTIFY isButton1Changed)

    modbus *mb;
public:
    explicit AppManager(QObject *parent = nullptr);
    ~AppManager();
    bool isButton1() const;
    void setIsButton1(bool newIsButton1);

public slots:
    void performOperation();

signals:

    void isButton1Changed();
    void operationFinished();
private:
    bool m_isButton1;
};

#endif // APPMANAGER_H
