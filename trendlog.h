#ifndef TRENDLOG_H
#define TRENDLOG_H

#include <QObject>
#include <QtCharts/QAbstractSeries>
#include <QtCharts/QLineSeries>
#include <QTimer>
#include <QDate>

class Trendlog : public QObject
{
    Q_OBJECT

    Q_PROPERTY(float value READ value WRITE setValue NOTIFY valueChanged)

public:
    explicit Trendlog(QObject *parent = nullptr);

    float value() const;
    void setValue(float newValue);

public slots:
    void startTrending(QAbstractSeries *series);
    void stopTrending();

signals:

    void valueChanged();

private:

    float m_value;
    QDateTime m_startDateTime;
    QLineSeries *qLineSeries;
    QTimer *timer;
    void timerTimeout();
};

#endif // TRENDLOG_H
