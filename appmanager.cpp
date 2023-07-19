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

    connect(thread, &QThread::started, mb, &modbus::pollModbus);
    mb->moveToThread(thread);
    thread->start();

    connect(mb, &modbus::updateData, this, &AppManager::parseModbusResponse);

    auto updateConnectedState = [&](bool connected){
        setIsModbusConnected(connected);
        qDebug() << "Connect state: " << connected;
    };
    connect(mb, &modbus::updateConnectedState,updateConnectedState);

    connect(this, &AppManager::writeRegister, mb, &modbus::writeHoldingRegister);
}

AppManager::~AppManager()
{

    delete tSmokeTrendlog;
}

bool AppManager::isButton1() const
{
    return m_isButton1;
}

void AppManager::setIsButton1(bool newIsButton1)
{
    if (m_isButton1 == newIsButton1)
        return;
    m_isButton1 = newIsButton1;
    emit isButton1Changed();
}

void AppManager::onClickButton1(bool val)
{
    qDebug()<< "Button 1 clicked, value: " << val;
    setIsButton1(val);
    qint16 value = val?1:0;
    emit writeRegister(99,value);
}

void AppManager::onClickButtonDrum()
{
    setButtonDrum(!buttonDrum());
    qint16 value = buttonDrum()?1:0;
    emit writeRegister(112,value);

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

void AppManager::startTrendlog(QAbstractSeries *series)
{
    tSmokeTrendlog->startTrending(series);
}

void AppManager::stopTrendlog()
{
    tSmokeTrendlog->stopTrending();
}

void AppManager::parseModbusResponse(QVector<quint16> data)
{
    qDebug() << data;
    setIsButton1(data[0]>0);
    setButtonDrum(data[13]>0);
    setButtonFire(data[23]>0);
    setButtonMixer(data[14]>0);
    setButtonCooler(data[20]>0);
    setTemperatureSmoke(modbus::toFloat(data[5], data[6]));
    tSmokeTrendlog->setValue(temperatureSmoke());
    setTemperatureProduct(modbus::toFloat(data[3], data[4]));
    setTemperatureROR(modbus::toFloat(data[45], data[46]));
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
