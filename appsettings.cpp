#include <QStandardPaths>
#include <QDir>

#include "appsettings.h"



AppSettings::AppSettings(QObject *parent) : QObject(parent)
{

}

AppSettings::~AppSettings()
{

}

/* Методы для подключения к базе данных
 * */
void AppSettings::connectToDataBase()
{
    if (QSqlDatabase::database().tables().contains(TABLE)) {
        qDebug() << "Data base was open!";
        initData();
        return;
    }
    if(!createTable()){
        qDebug() << "Ошибка создания таблицы";
        return;
    }
}


/* Методы закрытия базы данных
 * */
void AppSettings::closeDataBase()
{
    db.close();
}

/* Метод для создания таблицы в базе данных
 * */
bool AppSettings::createTable()
{
    /* В данном случае используется формирование сырого SQL-запроса
     * с последующим его выполнением.
     * */
    QSqlQuery query;
    if(!query.exec( "CREATE TABLE " TABLE " ("
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                            TABLE_BACKCOLOR         " TEXT       NOT NULL,"
                            TABLE_BACKIMAGE         " TEXT       NOT NULL,"
                            TABLE_THEME             " TEXT       NOT NULL,"
                            TABLE_AUTONIGHTMODE     " bit        NOT NULL,"
                            TABLE_MESSAGETEXTSIZE   " tinyint    NOT NULL,"
                            TABLE_LANGUAGE          " TEXT       NOT NULL"
                        " )"
                    )){
        qDebug() << "DataBase: error of create " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        insertIntoTable("default", "non", "Dark", 0, 12, "Rus");
        initData();
        return true;
    }
}

bool AppSettings::initData()
{
    QSqlQuery query;
    if(!query.exec("SELECT * FROM " TABLE)){
        qDebug() << "Не удалось получить данные для инициализации настроек";
        qDebug() << query.lastError();
        return false;
    }
    while(query.next())
    {   setBackgroundColor(query.value(1).toString());
        setBackgroundImage(query.value(2).toString());
        setTheme(query.value(3).toString());
        setAutoNight(query.value(4).toBool());
        setMessTextSize(query.value(5).toInt());
        setLanguage(query.value(6).toString());
    }
    return true;
}

/* Метод для вставки записи в базу данных
 * */
bool AppSettings::insertIntoTable(const QVariantList &data)
{

    QSqlQuery query;

    query.prepare("INSERT INTO " TABLE " ( " TABLE_BACKCOLOR ", "
                                             TABLE_BACKIMAGE ", "
                                             TABLE_THEME     ", "
                                             TABLE_AUTONIGHTMODE ", "
                                             TABLE_MESSAGETEXTSIZE ", "
                                             TABLE_LANGUAGE " ) "
                  "VALUES (:backcolor, :backimage, :theme, :autonight, :textsize, :lang)");
    query.bindValue(":backcolor",       data[0].toString());
    query.bindValue(":backimage",       data[1].toString());
    query.bindValue(":theme",           data[2].toString());
    query.bindValue(":autonight",       data[3].toBool());
    query.bindValue(":textsize",        data[4].toInt());
    query.bindValue(":lang",            data[5].toString());

    // После чего выполняется запросом методом exec()
    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
}

/* Второй метод для вставки записи в базу данных
 * */

bool AppSettings::insertIntoTable(const QString &backColor, const QString &backImg, const QString &theme,
                                   const bool &nightModeAuto, const int &textSize, const QString &lang)
{
    QVariantList tmp;
    tmp.append(backColor); tmp.append(backImg); tmp.append(theme);
    tmp.append(nightModeAuto); tmp.append(textSize); tmp.append(lang);
    if(insertIntoTable(tmp))
        return true;
    else
        return false;
}

bool AppSettings::updateTable(const QString &upColumn, const QString &upColumnValue)
{
    QSqlQuery query;
    QString q = "UPDATE "  TABLE  " SET " + upColumn + " = \'" + upColumnValue + "\' WHERE id = 1";
    if(query.exec(q))
        return true;
    else {
        qDebug()<< query.lastError();
    }
    return false;
}

bool AppSettings::updateTable(const QString &upColumn, const int &upColumnValue)
{
    QSqlQuery query;
    QString q = "UPDATE "  TABLE  " SET " + upColumn + " = " + QString::number(upColumnValue) + " WHERE id = 1";
    if(query.exec(q))
        return true;
    else {
        qDebug()<< query.lastError();
    }
    return false;
}


// Метод для удаления записи из таблицы


