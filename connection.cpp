#include <QCryptographicHash>

#include "QDebug"


#include <QJsonObject>
#include <QJsonObject>
#include <QJsonParseError>

#include "connection.h"


Connection::Connection(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);
    socket->connectToHost("localhost",1234);
    if(!socket->isOpen()){
        qDebug() << "No";
    }
    // socket connections
    connect(socket,SIGNAL(readyRead()),this,SLOT(readyRead()));
    connect(socket,SIGNAL(disconnected()),this,SLOT(disconnected()));
}


void Connection::readyRead()
{
    data = socket->readAll();
    qDebug() << data;

    QJsonDocument jsonDoc;
    QJsonParseError jsonErr;
    jsonDoc = QJsonDocument::fromJson(data, &jsonErr);
    if (jsonErr.error == QJsonParseError::NoError){
        QString nick = jsonDoc.object().value("nick").toString();
        QString email = jsonDoc.object().value("email").toString();
        emit getLoginAndEmail(nick ,email);
        emit authStatusOk();
    }
    else {
        qDebug() << jsonErr.errorString();
        emit authStatusBad();
    }

}


void Connection::disconnected()
{
    socket->deleteLater();
}

void Connection::sendRegisterData(QString email, QString nickName, QString password)
{
    QByteArray jsonData;
    QByteArray hashPassword = password.toUtf8();

    jsonData.append("{\"email\":\"" + email + "\",");
    jsonData.append("\"nick\":\""  + nickName + "\",");
    jsonData.append("\"pass\":\""  + QCryptographicHash::hash(hashPassword,QCryptographicHash::Sha256).toHex()  + "\",");
    jsonData.append("\"type\":\"register\"}");
    socket->write(jsonData);
}

void Connection::sendAuthData(QString email, QString password)
{
    QByteArray jsonData;
    QByteArray hashPassword = password.toUtf8();

    jsonData.append("{\"email\":\"" + email + "\",");
    jsonData.append("\"pass\":\""  + QCryptographicHash::hash(hashPassword,QCryptographicHash::Sha256).toHex() + "\",");
    jsonData.append("\"type\":\"auth\"}");
    socket->write(jsonData);
}
