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

    if(data == "register!"){
        emit authStatusOk();
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
    jsonData.append("{\"email\":\"" + email + "\",");
    jsonData.append("\"pass\":\""  + password + "\",");
    jsonData.append("\"type\":\"auth\"}");
    socket->write(jsonData);
}
