#ifndef CONNECTION_H
#define CONNECTION_H

#include <QObject>
#include <QTcpSocket>
#include <QJsonObject>
#include <QJsonObject>
#include <QJsonParseError>

class Connection : public QObject
{
    Q_OBJECT


public:
    explicit Connection(QObject *parent = nullptr);

    enum status{
        CONNECTED = 0,
        DISCONNECTED
    };


private:
    QTcpSocket *socket;
    QByteArray data;
    QJsonDocument jsonDoc;
    QJsonParseError jsonErr;


public slots:
    void readyRead();
    void disconnected();

    void sendRegisterData(QString email, QString nickName, QString password);
    void sendAuthData(QString email, QString password);
    //void sendMessage(QString recepient, QString data);


signals:
    void authStatusOk();
    void authStatusBad();
};

#endif // CONNECTION_H
