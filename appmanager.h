#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include "modbus.h"
#include "trendlog.h"

#include <QtCharts/QAbstractSeries>

class AppManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isButton1 READ isButton1 WRITE setIsButton1 NOTIFY isButton1Changed)
    Q_PROPERTY(bool isModbusConnected READ isModbusConnected WRITE setIsModbusConnected NOTIFY isModbusConnectedChanged)
    Q_PROPERTY(bool buttonDrum READ buttonDrum WRITE setButtonDrum NOTIFY buttonDrumChanged)
    Q_PROPERTY(bool buttonFire READ buttonFire WRITE setButtonFire NOTIFY buttonFireChanged)
    Q_PROPERTY(bool buttonMixer READ buttonMixer WRITE setButtonMixer NOTIFY buttonMixerChanged)
    Q_PROPERTY(bool buttonCooler READ buttonCooler WRITE setButtonCooler NOTIFY buttonCoolerChanged)
    Q_PROPERTY(float temperatureSmoke READ temperatureSmoke WRITE setTemperatureSmoke NOTIFY temperatureSmokeChanged)
    Q_PROPERTY(float temperatureProduct READ temperatureProduct WRITE setTemperatureProduct NOTIFY temperatureProductChanged)
    Q_PROPERTY(float temperatureROR READ temperatureROR WRITE setTemperatureROR NOTIFY temperatureRORChanged)


public:
    explicit AppManager(QObject *parent = nullptr);
    ~AppManager();
    bool isButton1() const;
    void setIsButton1(bool newIsButton1);

    bool isModbusConnected() const;
    void setIsModbusConnected(bool newIsModbusConnected);

    bool buttonDrum() const;
    void setButtonDrum(bool newButtonDrum);

    bool buttonFire() const;
    void setButtonFire(bool newButtonFire);

    bool buttonMixer() const;
    void setButtonMixer(bool newButtonMixer);

    bool buttonCooler() const;
    void setButtonCooler(bool newButtonCooler);

    float temperatureSmoke() const;
    void setTemperatureSmoke(float newTemperatureSmoke);

    float temperatureProduct() const;
    void setTemperatureProduct(float newTemparatureProduct);

    float temperatureROR() const;
    void setTemperatureROR(float newTemperatureROR);

public slots:
    void onClickButton1(bool val);
    void onClickButtonDrum();
    void onClickButtonFire();
    void onClickButtonMixer();
    void onClickButtonCooler();

    void updateChart(QAbstractSeries *series);
    void startTrendlog(QAbstractSeries *series);

signals:
    void isButton1Changed();
    void isModbusConnectedChanged();
    void writeRegister(int addr, qint16 value);

    void buttonDrumChanged();

    void buttonFireChanged();

    void buttonMixerChanged();

    void buttonCoolerChanged();

    void temperatureSmokeChanged();

    void temperatureProductChanged();

    void temperatureRORChanged();

private:
    modbus *mb;
    Trendlog *tSmokeTrendlog;
    void parseModbusResponse(QVector<quint16> data);
    bool m_isButton1;
    bool m_isModbusConnected;
    bool m_buttonDrum;
    bool m_buttonFire;
    bool m_buttonMixer;
    bool m_buttonCooler;
    float m_temperatureSmoke;
    float m_temperatureProduct;
    float m_temperatureROR;
};

#endif // APPMANAGER_H
