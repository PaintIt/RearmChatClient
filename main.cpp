#include <QGuiApplication>
#include <QStandardPaths>
#include <QSqlDatabase>
#include <QSqlError>
#include <QtQml>
#include <QDebug>
#include <QtQuick>

#include "sqlcontactmodel.h"
#include "sqlconversationmodel.h"

#include "connection.h"


static void connectToDatabase()
{
    QSqlDatabase database = QSqlDatabase::database();
    if (!database.isValid()) {
        database = QSqlDatabase::addDatabase("QSQLITE");
        if (!database.isValid())
            qFatal("Cannot add database: %s", qPrintable(database.lastError().text()));
    }

    const QDir writeDir = QStandardPaths::writableLocation(QStandardPaths::ApplicationsLocation);
    if (!writeDir.mkpath("."))
        qFatal("Failed to create writable directory at %s", qPrintable(writeDir.absolutePath()));

    // Ensure that we have a writable location on all devices.
    const QString fileName = writeDir.absolutePath() + "/chat-database.sqlite3";
    qDebug() << fileName;
    // When using the SQLite driver, open() will create the SQLite database if it doesn't exist.
    database.setDatabaseName(fileName);
    if (!database.open()) {
        QFile::remove(fileName);
        qFatal("Cannot open database: %s", qPrintable(database.lastError().text()));
    }
}


int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<SqlContactModel>("chatmodel", 1, 0, "SqlContactModel");
    qmlRegisterType<SqlConversationModel>("chatmodel", 1, 0, "SqlConversationModel");

    Connection connect;
    QQmlApplicationEngine engine;

    app.setOrganizationName("Emir");
    app.setOrganizationDomain("babaev_emir@mail.ru");
    app.setApplicationName("Rearm");

    connectToDatabase();
    engine.rootContext()->setContextProperty("connect", &connect);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

