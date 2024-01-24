#include "appmanager.h"
#include <QDebug>
#include <QThread>
#include <QtCharts/QXYSeries>
#include <QtCharts/QLineSeries>


AppManager::AppManager(QObject *parent) : QObject{parent}
{
    QThread *thread = new QThread;
    mb = new modbus();
    tSmokeTrendlog = new Trendlog(this);
    tProductTrendlog = new Trendlog(this);
    tRORTrendlog = new Trendlog(this);
    alarmList = new AlarmList(this);

    connect(thread, &QThread::started, mb, &modbus::pollModbus);
    mb->moveToThread(thread);
    thread->start();

    connect(mb, &modbus::updateData, this, &AppManager::parseModbusResponse);

    auto updateConnectedState = [&](bool connected){
        setIsModbusConnected(connected);
        qDebug() << "Connect state: " << connected;
        if(!connected){
            setTemperatureProduct(0);
            setTemperatureSmoke(0);
            setDP(0);
            setButtonDrum(false);
            setButtonMixer(false);
            setDrumSP(0);
            setFanSP(0);
            setButtonCooler(false);
            setButtonFire(false);
            setAlarmState(false);
            setTemperatureROR(0);
            setGazPreset(0);
        }
    };
    connect(mb, &modbus::updateConnectedState,updateConnectedState);

    connect(this, &AppManager::writeRegister, mb, &modbus::writeHoldingRegister);
    connect(this, &AppManager::writeFloat, mb, &modbus::writeFloatHolding);

}

AppManager::~AppManager()
{

    delete tSmokeTrendlog;
    delete tProductTrendlog;
    delete tRORTrendlog;
}

void AppManager::onClickButtonDrum()
{
    setButtonDrum(!buttonDrum());
//    qint16 value = buttonDrum()?1:0;
//    emit writeRegister(112,value);
    emit writeRegister(112,buttonDrum()?1:0);
}

void AppManager::onClickButtonFire()
{
    setButtonFire(!buttonFire());
    qint16 value = buttonFire()?1:0;
    emit writeRegister(122,value);
}

void AppManager::onClickButtonMixer()
{
    setButtonMixer(!buttonMixer());
    qint16 value = buttonMixer()?1:0;
    emit writeRegister(113,value);
}

void AppManager::onClickButtonCooler()
{
    setButtonCooler(!buttonCooler());
    qint16 value = buttonCooler()?1:0;
    emit writeRegister(119,value);
}

void AppManager::onClickAck()
{
    emit writeRegister(101, 1);
}

void AppManager::onSetFireLevel(int lvl)
{
    setGazPreset(lvl);
    emit writeRegister(168,lvl);
}

void AppManager::onSetDrumSpeed(float spd)
{
    setDrumSP(spd);
    emit writeFloat(114,spd);
}

void AppManager::onSetFanSpeed(float spd)
{
    setFanSP(spd);
    emit writeFloat(117,spd);
}

void AppManager::startTrendlog(QAbstractSeries *tSmokeSeries, QAbstractSeries *tProductSeries, QAbstractSeries *tRORSeries)
{
    tSmokeTrendlog->startTrending(tSmokeSeries);
    tProductTrendlog->startTrending(tProductSeries);
    tRORTrendlog->startTrending(tRORSeries);
}

void AppManager::stopTrendlog()
{
    tSmokeTrendlog->stopTrending();
    tProductTrendlog->stopTrending();
    tRORTrendlog->stopTrending();
}

void AppManager::onSetTemperatureOverheat(float t)
{
    setTemperatureOverheatSP(t);
    emit writeFloat(106, t);
}

void AppManager::parseModbusResponse(QVector<quint16> data)
{
//    qDebug() << data;
    setTemperatureProduct(modbus::toFloat(data[3], data[4]));
    tProductTrendlog->setValue(temperatureProduct());
    setTemperatureSmoke(modbus::toFloat(data[5], data[6]));
    tSmokeTrendlog->setValue(temperatureSmoke());
    setTemperatureOverheatSP(modbus::toFloat(data[7], data[8]));

    setDP(modbus::toFloat(data[9], data[10]));


    setButtonDrum(data[13]>0);
    setButtonMixer(data[14]>0);
    setDrumSP(modbus::toFloat(data[15], data[16]));
    setFanSP(modbus::toFloat(data[18], data[19]));
    setButtonCooler(data[20]>0);

    setButtonFire(data[23]>0);

    setAlarmState(data[27]>0);

    setTemperatureROR(modbus::toFloat(data[45], data[46]));
    tRORTrendlog->setValue(temperatureROR());

    setGazPreset(data[69]);

//// Alarm list
//    QVector<quint16> *tmpAlmV;
//    tmpAlmV = new QVector<quint16>();
//    tmpAlmV->append(data[0]);
//    tmpAlmV->append(data[1]);
////    qInfo()<<*tmpAlmV;
//    if(alarmList->checkAlarms(tmpAlmV, &m_almIntList)) {
//        emit almIntListChanged();
//        qInfo() << almIntList();
//    }

    emit processAlarms(data.first(2));
}

bool AppManager::isModbusConnected() const
{
    return m_isModbusConnected;
}

void AppManager::setIsModbusConnected(bool newIsModbusConnected)
{
    if (m_isModbusConnected == newIsModbusConnected)
        return;
    m_isModbusConnected = newIsModbusConnected;
    emit isModbusConnectedChanged();
}

bool AppManager::buttonDrum() const
{
    return m_buttonDrum;
}

void AppManager::setButtonDrum(bool newButtonDrum)
{
    if (m_buttonDrum == newButtonDrum)
        return;
    m_buttonDrum = newButtonDrum;
    emit buttonDrumChanged();
}

bool AppManager::buttonFire() const
{
    return m_buttonFire;
}

void AppManager::setButtonFire(bool newButtonFire)
{
    if (m_buttonFire == newButtonFire)
        return;
    m_buttonFire = newButtonFire;
    emit buttonFireChanged();
}

bool AppManager::buttonMixer() const
{
    return m_buttonMixer;
}

void AppManager::setButtonMixer(bool newButtonMixer)
{
    if (m_buttonMixer == newButtonMixer)
        return;
    m_buttonMixer = newButtonMixer;
    emit buttonMixerChanged();
}

bool AppManager::buttonCooler() const
{
    return m_buttonCooler;
}

void AppManager::setButtonCooler(bool newButtonCooler)
{
    if (m_buttonCooler == newButtonCooler)
        return;
    m_buttonCooler = newButtonCooler;
    emit buttonCoolerChanged();
}

float AppManager::temperatureSmoke() const
{
    return m_temperatureSmoke;
}

void AppManager::setTemperatureSmoke(float newTemperatureSmoke)
{
    if (qFuzzyCompare(m_temperatureSmoke, newTemperatureSmoke))
        return;
    m_temperatureSmoke = newTemperatureSmoke;
    emit temperatureSmokeChanged();
}

float AppManager::temperatureProduct() const
{
    return m_temperatureProduct;
}

void AppManager::setTemperatureProduct(float newTemparatureProduct)
{
    if (qFuzzyCompare(m_temperatureProduct, newTemparatureProduct))
        return;
    m_temperatureProduct = newTemparatureProduct;
    emit temperatureProductChanged();
}

float AppManager::temperatureROR() const
{
    return m_temperatureROR;
}

void AppManager::setTemperatureROR(float newTemperatureROR)
{
    if (qFuzzyCompare(m_temperatureROR, newTemperatureROR))
        return;
    m_temperatureROR = newTemperatureROR;
    emit temperatureRORChanged();
}

float AppManager::dP() const
{
    return m_dP;
}

void AppManager::setDP(float newDP)
{
    if (qFuzzyCompare(m_dP, newDP))
        return;
    m_dP = newDP;
    emit dPChanged();
}

float AppManager::drumSP() const
{
    return m_drumSP;
}

void AppManager::setDrumSP(float newDrumSP)
{
    if (qFuzzyCompare(m_drumSP, newDrumSP))
        return;
    m_drumSP = newDrumSP;
    emit drumSPChanged();
}

float AppManager::fanSP() const
{
    return m_fanSP;
}

void AppManager::setFanSP(float newFanSP)
{
    if (qFuzzyCompare(m_fanSP, newFanSP))
        return;
    m_fanSP = newFanSP;
    emit fanSPChanged();
}

bool AppManager::alarmState() const
{
    return m_alarmState;
}

void AppManager::setAlarmState(bool newAlarmState)
{
    if (m_alarmState == newAlarmState)
        return;
    m_alarmState = newAlarmState;
    emit alarmStateChanged();
}

int AppManager::gazPreset() const
{
    return m_gazPreset;
}

void AppManager::setGazPreset(int newGazPreset)
{
    if (m_gazPreset == newGazPreset)
        return;
    m_gazPreset = newGazPreset;
    emit gazPresetChanged();
}

QList<int> AppManager::almIntList() const
{
    return m_almIntList;
}

void AppManager::setAlmIntList(const QList<int> &newAlmIntList)
{
    if (m_almIntList == newAlmIntList)
        return;
    m_almIntList = newAlmIntList;
    emit almIntListChanged();
}

float AppManager::temperatureOverheatSP() const
{
    return m_temperatureOverheatSP;
}

void AppManager::setTemperatureOverheatSP(float newTemperatureOverheatSP)
{
    if (qFuzzyCompare(m_temperatureOverheatSP, newTemperatureOverheatSP))
        return;
    m_temperatureOverheatSP = newTemperatureOverheatSP;
    emit temperatureOverheatSPChanged();
}
