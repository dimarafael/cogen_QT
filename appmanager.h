#ifndef APPMANAGER_H
#define APPMANAGER_H

#include <QObject>
#include "modbus.h"
#include "trendlog.h"
#include "alarmlist.h"

#include <QtCharts/QAbstractSeries>

class AppManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isModbusConnected READ isModbusConnected WRITE setIsModbusConnected NOTIFY isModbusConnectedChanged)
    Q_PROPERTY(bool buttonDrum READ buttonDrum WRITE setButtonDrum NOTIFY buttonDrumChanged)
    Q_PROPERTY(bool buttonFire READ buttonFire WRITE setButtonFire NOTIFY buttonFireChanged)
    Q_PROPERTY(bool buttonMixer READ buttonMixer WRITE setButtonMixer NOTIFY buttonMixerChanged)
    Q_PROPERTY(bool buttonCooler READ buttonCooler WRITE setButtonCooler NOTIFY buttonCoolerChanged)
    Q_PROPERTY(float temperatureSmoke READ temperatureSmoke WRITE setTemperatureSmoke NOTIFY temperatureSmokeChanged)
    Q_PROPERTY(float temperatureProduct READ temperatureProduct WRITE setTemperatureProduct NOTIFY temperatureProductChanged)
    Q_PROPERTY(float temperatureROR READ temperatureROR WRITE setTemperatureROR NOTIFY temperatureRORChanged)
    Q_PROPERTY(float dP READ dP WRITE setDP NOTIFY dPChanged)
    Q_PROPERTY(float drumSP READ drumSP WRITE setDrumSP NOTIFY drumSPChanged)
    Q_PROPERTY(float fanSP READ fanSP WRITE setFanSP NOTIFY fanSPChanged)
    Q_PROPERTY(bool alarmState READ alarmState WRITE setAlarmState NOTIFY alarmStateChanged)
    Q_PROPERTY(int gazPreset READ gazPreset WRITE setGazPreset NOTIFY gazPresetChanged)
    Q_PROPERTY(QList<int> almIntList READ almIntList WRITE setAlmIntList NOTIFY almIntListChanged)

    Q_PROPERTY(float temperatureOverheatSP READ temperatureOverheatSP WRITE setTemperatureOverheatSP NOTIFY temperatureOverheatSPChanged)

public:
    explicit AppManager(QObject *parent = nullptr);
    ~AppManager();

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

    float dP() const;
    void setDP(float newDP);

    float drumSP() const;
    void setDrumSP(float newDrumSP);

    float fanSP() const;
    void setFanSP(float newFanSP);

    bool alarmState() const;
    void setAlarmState(bool newAlarmState);

    int gazPreset() const;
    void setGazPreset(int newGazPreset);

    QList<int> almIntList() const;
    void setAlmIntList(const QList<int> &newAlmIntList);

    float temperatureOverheatSP() const;
    void setTemperatureOverheatSP(float newTemperatureOverheatSP);

public slots:
    void onClickButtonDrum();
    void onClickButtonFire();
    void onClickButtonMixer();
    void onClickButtonCooler();

    void onClickAck();

    void onSetFireLevel(int lvl);
    void onSetDrumSpeed(float spd);
    void onSetFanSpeed(float spd);

    void startTrendlog(QAbstractSeries *tSmokeSeries, QAbstractSeries *tProductSeries, QAbstractSeries *tRORSeries);
    void stopTrendlog();

    void onSetTemperatureOverheat(float t);

signals:
    void isModbusConnectedChanged();
    void writeRegister(int addr, qint16 value);
    void writeFloat(int addr, float value);

    void buttonDrumChanged();

    void buttonFireChanged();

    void buttonMixerChanged();

    void buttonCoolerChanged();

    void temperatureSmokeChanged();

    void temperatureProductChanged();

    void temperatureRORChanged();

    void dPChanged();

    void drumSPChanged();

    void fanSPChanged();

    void alarmStateChanged();

    void gazPresetChanged();

    void almIntListChanged();

    void processAlarms(QVector<quint16> alarmData);

    void temperatureOverheatSPChanged();

private:
    modbus *mb;
    Trendlog *tSmokeTrendlog;
    Trendlog *tProductTrendlog;
    Trendlog *tRORTrendlog;
    AlarmList *alarmList;
    void parseModbusResponse(QVector<quint16> data);
    bool m_isModbusConnected;
    bool m_buttonDrum;
    bool m_buttonFire;
    bool m_buttonMixer;
    bool m_buttonCooler;
    float m_temperatureSmoke;
    float m_temperatureProduct;
    float m_temperatureROR;
    float m_dP;
    float m_drumSP;
    float m_fanSP;
    bool m_alarmState;
    int m_gazPreset;
    QList<int> m_almIntList;
    float m_temperatureOverheatSP;
};

#endif // APPMANAGER_H
