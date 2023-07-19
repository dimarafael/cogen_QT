#include "trendlog.h"
#include <QDate>

Trendlog::Trendlog(QObject *parent)
    : QObject{parent}
{
    timer = new QTimer(this);
}


float Trendlog::value() const
{
    return m_value;
}

void Trendlog::setValue(float newValue)
{
    if (qFuzzyCompare(m_value, newValue))
        return;
    m_value = newValue;
    emit valueChanged();
}

void Trendlog::startTrending(QAbstractSeries *series)
{
    qLineSeries = static_cast<QLineSeries *>(series);

    qLineSeries->clear();

    timer->start(1000);
    connect(timer, &QTimer::timeout, this, &Trendlog::timerTimeout);

    m_startDateTime = QDateTime::currentDateTime();
    qLineSeries->append(QDateTime::currentDateTime().toMSecsSinceEpoch()-m_startDateTime.toMSecsSinceEpoch(),value());
}

void Trendlog::stopTrending()
{
    timer->stop();
}

void Trendlog::timerTimeout()
{
    qLineSeries->append(QDateTime::currentDateTime().toMSecsSinceEpoch()-m_startDateTime.toMSecsSinceEpoch(),value());
}
